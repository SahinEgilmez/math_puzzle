import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/widgets/time.dart';
import 'package:math_puzzle/widgets/area.dart';
import 'package:math_puzzle/widgets/grid.dart';
import 'package:math_puzzle/utils/functions.dart';
import 'package:math_puzzle/utils/constants.dart';
import 'package:firebase_admob/firebase_admob.dart';

class GamePage extends StatefulWidget {
  GamePage(String op) {
    Util.operator = op;
    Util.updateLevel(0);
  }

  @override
  State<StatefulWidget> createState() {
    return _GamePage();
  }
}

class _GamePage extends State<GamePage> {
  List<Tile> tiles = [], draggedGrid = [];
  List<List<int>> grid = [];
  bool isgameOver = false;
  int score = 0, target = 0, highScore = 0;
  double width, height;
  TimeRemainer timeRemainer = new TimeRemainer(1.0);
  DataArea targetArea = new DataArea("Target", 0, Constants.AREA_COLOR);
  DataArea scoreArea = new DataArea("Score", 0, Constants.AREA_COLOR);
  DataArea highScoreArea = new DataArea("High Score", 0, Constants.AREA_COLOR);
  Grid gameGrid;
  MobileAdTargetingInfo targetingInfo;
  BannerAd bannerAd;
  InterstitialAd interstitialAd;

  @override
  void initState() {
    super.initState();
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['math', 'puzzle', 'game', 'mathematics'],
      childDirected: false,
      testDevices: <String>["118641BDD4C8B0DC8476684D19E74940"], // Android emulators are considered test devices
    );

    bannerAd = BannerAd(
        adUnitId: "ca-app-pub-5102346463770175/3996304421",
        size: AdSize.smartBanner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        });
    bannerAd.load();
    bannerAd.show(
      anchorType: AnchorType.bottom,
      anchorOffset: 0.0,
    );

    interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    interstitialAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }
  void initGrid(double width, double height) {
    grid = Functions.blankGrid();
    tiles.clear();
    for (int i = 0; i < Constants.GRID_NUMBER; i++) {
      for (int j = 0; j < Constants.GRID_NUMBER; j++) {
        String number = "${grid[i][j]}";
        double size;
        switch ("${number}".length) {
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
    gameGrid = new Grid(this.height, grid, tiles, draggedGrid, scoreArea, targetArea, highScoreArea, timeRemainer,interstitialAd);
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
          timeRemainer.timer.cancel();
          gameGrid.timer.cancel();
          Navigator.of(context).pop();
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[targetArea, timeRemainer],
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
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
