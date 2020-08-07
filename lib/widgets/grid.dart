import 'package:flutter/material.dart';
import 'package:math_puzzle/scenes/game.dart';
import 'package:math_puzzle/utils/ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/widgets/time.dart';
import 'package:math_puzzle/widgets/area.dart';
import 'package:math_puzzle/utils/engine.dart';
import 'package:math_puzzle/utils/constants.dart';

class Grid extends StatefulWidget {
  final GridState state = GridState();
  final double height;
  final List<Tile> tiles, draggedGrid;
  final List<List<int>> grid;
  final DataArea scoreArea, targetArea, highScoreArea;
  final TimeRemainer timeRemainer;

  Grid(this.height, this.grid, this.tiles, this.draggedGrid, this.scoreArea, this.targetArea, this.highScoreArea, this.timeRemainer);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class GridState extends State<Grid> {
  List<Tile> tiles, draggedGrid;
  List<List<int>> grid;
  bool gameOver;
  int score = 0, target = 0, highScore = 0;
  SharedPreferences sharedPreferences;
  Timer timer;

  GridState() {
    timer = Timer.periodic(Constants.SECOND, (Timer t) => periodicTimer());
  }

  @override
  void initState() {
    this.grid = widget.grid;
    this.tiles = widget.tiles;
    this.draggedGrid = widget.draggedGrid;
    gameOver = false;
    setHighScoreAndTarget();
    super.initState();
  }

  void periodicTimer() {
    if (widget.timeRemainer.isGameOver() && this.mounted) {
      print("Grid periodicTimer()");
      changeState(widget.timeRemainer.isGameOver());
      Ads.showInterstitialAd();
      if (this.score > 100) {
      } else {
        print("SCORE IS NOT ENOUGH" + this.score.toString());
      }
      widget.timeRemainer.timerCancel();
    }
  }

  void changeState(bool gameOver) {
    setState(() {
      this.gameOver = gameOver;
    });
  }

  void setHighScoreAndTarget() async {
    target = Engine.targetGenerator(grid, Engine.count);
    widget.targetArea.changeData(target);
    sharedPreferences = await SharedPreferences.getInstance();
    if (Engine.operator == Constants.MULT) {
      highScore = sharedPreferences.getInt('high_score_math_puzzle_multiplication');
      if (highScore == null) {
        highScore = 0;
        sharedPreferences.setInt('high_score_math_puzzle_multiplication', highScore);
      } else {
        if (score > highScore) {
          sharedPreferences.setInt('high_score_math_puzzle_multiplication', score);
          highScore = score;
        }
      }
    } else if (Engine.operator == Constants.PLUS) {
      highScore = sharedPreferences.getInt('high_score_math_puzzle_addition');
      if (highScore == null) {
        highScore = 0;
        sharedPreferences.setInt('high_score_math_puzzle_addition', highScore);
      } else {
        if (score > highScore) {
          sharedPreferences.setInt('high_score_math_puzzle_addition', score);
          highScore = score;
        }
      }
    }
    widget.highScoreArea.changeData(highScore);
  }

  void update() {
    int sum;
    List<List<int>> oldPoints = [];
    if (Engine.operator == Constants.PLUS) {
      sum = 0;
      for (int i = 0; i < draggedGrid.length; i++) {
        sum += int.parse(draggedGrid[i].getNumber());
        draggedGrid[i].changeColor(Constants.EMPTY_GRID_COLOR);
        oldPoints.add([draggedGrid[i].x, draggedGrid[i].y]);
      }
    } else if (Engine.operator == Constants.MULT) {
      sum = 1;
      for (int i = 0; i < draggedGrid.length; i++) {
        sum *= int.parse(draggedGrid[i].getNumber());
        draggedGrid[i].changeColor(Constants.EMPTY_GRID_COLOR);
        oldPoints.add([draggedGrid[i].x, draggedGrid[i].y]);
      }
    }
    if (draggedGrid.length == 1) {
      sum = 0;
    }
    draggedGrid.clear();
    print("SUM:" + sum.toString() + "TARGET:" + target.toString());
    if (sum == target) {
      for (int i = 0; i < oldPoints.length; i++) {
        int index = (4 * oldPoints[i][0]) + oldPoints[i][1];
        int newInt = Engine.gridNumGenerator(grid);
        grid[oldPoints[i][0]][oldPoints[i][1]] = newInt;
        tiles[index].changeNumber(newInt.toString());
      }
      setHighScoreAndTarget();
      widget.scoreArea.addToData(sum);
      score = widget.scoreArea.getData();
      widget.timeRemainer.changePercent(1.0);
      Engine.updateLevel(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      color: Constants.BACKGROUND_COLOR,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: GridView.count(
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              padding: EdgeInsets.all(0.0),
              crossAxisCount: 4,
              children: tiles,
            ),
            onPanUpdate: (DragUpdateDetails details) {
              Tile tile = Engine.draggedGridDetector(tiles, details.globalPosition);
              if (tile != null && !Engine.isDraggedGrid(draggedGrid, tile)) {
                draggedGrid.add(tile);
                tile.changeColor(Constants.GRID_WIN_COLOR);
              }
            },
            onPanEnd: (DragEndDetails details) {
              this.update();
            },
          ),
          gameOver
              ? Container(
                  height: widget.height,
                  color: Constants.BACKGROUND_COLOR,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'GAME OVER!\n',
                        style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Constants.GAME_OVER_COLOR),
                      ),
                      Text(
                        'YOUR SCORE IS',
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Constants.GAME_OVER_COLOR),
                      ),
                      Text(
                        '$score',
                        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Constants.GAME_OVER_COLOR),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Constants.GAME_OVER_COLOR,
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: Icon(
                              Icons.refresh,
                              color: Constants.GAME_OVER_COLOR,
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GameScene(Engine.operator)),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
