import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_puzzle/utils/ads.dart';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/widgets/time.dart';
import 'package:math_puzzle/widgets/area.dart';
import 'package:math_puzzle/widgets/grid.dart';
import 'package:math_puzzle/utils/engine.dart';
import 'package:math_puzzle/utils/constants.dart';

class GameScene extends StatefulWidget {
  final GameState state = GameState();

  GameScene(String op) {
    Engine.operator = op;
    Engine.updateLevel(0);
  }

  @override
  State<StatefulWidget> createState() => state;
}

class GameState extends State<GameScene> {
  List<Tile> tiles = [], draggedGrid = [];
  List<List<int>> grid = [];
  bool isgameOver = false;
  int score = 0, target = 0, highScore = 0;
  double width, height;
  TimeRemainer timeRemainer = new TimeRemainer(1.0);
  DataArea targetArea = new DataArea("Target", Constants.AREA_COLOR);
  DataArea scoreArea = new DataArea("Score", Constants.AREA_COLOR);
  DataArea highScoreArea = new DataArea("High Score", Constants.AREA_COLOR);
  Grid gameGrid;

  void initGrid(double width, double height) {
    grid = Engine.blankGrid();
    tiles.clear();
    for (int i = 0; i < Constants.GRID_NUMBER; i++) {
      for (int j = 0; j < Constants.GRID_NUMBER; j++) {
        String number = "${grid[i][j]}";
        double size;
        switch ("$number".length) {
          case 1:
            size = 40.0;
            break;
          case 2:
            size = 40.0;
            break;
          case 3:
            size = 30.0;
            break;
          case 4:
            size = 20.0;
            break;
        }
        tiles.add(Tile(number, width, height, Constants.EMPTY_GRID_COLOR, size, i, j));
      }
    }
    gameGrid = new Grid(this.height, grid, tiles, draggedGrid, scoreArea, targetArea, highScoreArea, timeRemainer);
  }

  @override
  void initState() {
    Ads.showGameBanner(this);
    super.initState();
  }

  @override
  void deactivate() {
    Ads.hideGameBanner();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 80) / 4;
    double gridHeight = gridWidth;
    height = 50 + (gridHeight * 4);
    initGrid(gridWidth, gridHeight);

    return new WillPopScope(
        onWillPop: () {
          timeRemainer.timerCancel();
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          backgroundColor: Constants.BACKGROUND_COLOR,
          body: Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[targetArea,SizedBox(height: 5), timeRemainer],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: gameGrid,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[scoreArea, highScoreArea],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text("OPERATION: " + Engine.operator),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
