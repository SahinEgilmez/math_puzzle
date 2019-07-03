import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/widgets/time.dart';
import 'package:math_puzzle/widgets/area.dart';
import 'package:math_puzzle/utils/functions.dart';
import 'package:math_puzzle/utils/constants.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Grid extends StatefulWidget {
  _Grid state;
  double height;
  List<Tile> tiles, draggedGrid;
  List<List<int>> grid = [];
  DataArea scoreArea, targetArea, highScoreArea;
  TimeRemainer timeRemainer;
  Timer timer;
  InterstitialAd interstitialAd;

  Grid(this.height, this.grid, this.tiles, this.draggedGrid, this.scoreArea, this.targetArea, this.highScoreArea,
      this.timeRemainer, this.interstitialAd) {
    timer = Timer.periodic(Constants.SECOND, (Timer t) => this.periodicTimer());
  }

  @override
  State<StatefulWidget> createState() {
    state = _Grid(height, grid, tiles, draggedGrid, scoreArea, targetArea, highScoreArea, timeRemainer);
    return state;
  }

  void periodicTimer() {
    if (timeRemainer.gameOver && timer.isActive && state != null) {
      changeState();
      interstitialAd.show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );
      timer.cancel();
      timeRemainer.timer.cancel();
    }
  }

  void changeState() {
    state.changeState(timeRemainer.gameOver);
  }
}

class _Grid extends State<Grid> {
  double height;
  List<Tile> tiles, draggedGrid;
  List<List<int>> grid;
  DataArea scoreArea, targetArea, highScoreArea;
  TimeRemainer timeRemainer;
  bool gameOver;
  static int score = 0, target = 0, highScore = 0;
  SharedPreferences sharedPreferences;

  _Grid(this.height, this.grid, this.tiles, this.draggedGrid, this.scoreArea, this.targetArea, this.highScoreArea,
      this.timeRemainer) {
    setHighScoreAndTarget();
    gameOver = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void changeState(bool gameOver) {
    setState(() {
      this.gameOver = gameOver;
    });
  }

  void setHighScoreAndTarget() async {
    gameOver = false;
    target = Functions.targetGenerator(grid, Util.count);
    targetArea.changeData(target);
    sharedPreferences = await SharedPreferences.getInstance();
    if (Util.operator == Constants.MULT) {
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
    } else if (Util.operator == Constants.PLUS) {
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
    highScoreArea.changeData(highScore);
  }

  void update() {
    int sum;
    List<List<int>> oldPoints = [];
    if (Util.operator == Constants.PLUS) {
      sum = 0;
      for (int i = 0; i < draggedGrid.length; i++) {
        sum += int.parse(draggedGrid[i].number);
        draggedGrid[i].changeColor(Constants.EMPTY_GRID_COLOR);
        oldPoints.add([draggedGrid[i].x, draggedGrid[i].y]);
      }
    } else if (Util.operator == Constants.MULT) {
      sum = 1;
      for (int i = 0; i < draggedGrid.length; i++) {
        sum *= int.parse(draggedGrid[i].number);
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
        int newInt = Functions.gridNumGenerator(grid);
        grid[oldPoints[i][0]][oldPoints[i][1]] = newInt;
        tiles[index].number = newInt.toString();
      }
      setHighScoreAndTarget();
      scoreArea.addToData(sum);
      score = scoreArea.data;
      timeRemainer.changePercent(1.0);
      Util.updateLevel(score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
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
              Tile tile = Functions.draggedGridDetector(tiles, details.globalPosition);
              if (tile != null && !Functions.isDraggedGrid(draggedGrid, tile)) {
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
                  height: height,
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
