import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/utils/constants.dart';

class Engine {
  static String operator;
  static int level = 1;
  static int min = 1;
  static int max = 20;
  static int count = 2;
  static double period = 0.010; //0.010

  static void updateLevel(int score) {
    if (score < 100)
      level = 1;
    else if (score < 200)
      level = 2;
    else if (score < 500)
      level = 3;
    else if (score < 1000)
      level = 4;
    else if (score < 2500)
      level = 5;
    else if (score < 10000)
      level = 6;
    else if (score < 20000)
      level = 7;
    else if (score < 50000)
      level = 8;
    else if (score < 100000)
      level = 9;
    else
      level = 10;

    switch (level) {
      case 1:
        period = 0.050; //0.010
        count = 2;
        break;
      case 2:
        period = 0.020;
        break;
      case 3:
        period = 0.025;
        count = 3;
        max = 25;
        break;
      case 4:
        period = 0.030;
        max = 30;
        break;
      case 5:
        period = 0.035;
        count = 4;
        max = 35;
        break;
      case 6:
        period = 0.040;
        max = 40;
        break;
      case 7:
        period = 0.045;
        max = 45;
        break;
      case 8:
        period = 0.050;
        max = 50;
        break;
      case 9:
        period = 0.055;
        max = 55;
        break;
      case 10:
        count = 5;
        period = 0.060;
        max = 60;
        break;
    }
  }

  static List<List<int>> blankGrid() {
    List<List<int>> rows = [];
    for (int i = 0; i < Constants.GRID_NUMBER; i++) {
      rows.add([gridNumGenerator(rows), gridNumGenerator(rows), gridNumGenerator(rows), gridNumGenerator(rows)]);
    }
    return rows;
  }

  static int gridNumGenerator(List<List<int>> rows) {
    int rnd = 1;
    rnd = random(min, max);
    bool res = true;
    for (int i = 0; i < rows.length; i++) {
      if (rows[i] != null && rows[i].contains(rnd)) {
        res = false;
        break;
      }
    }
    if (!res)
      return gridNumGenerator(rows);
    else
      return rnd;
  }

  static int random(int min, int max) {
    var rnd = new Random();
    int res = (min + rnd.nextInt(max - min));
    return res;
  }

  static int targetGenerator(List<List<int>> grid, int counter) {
    int x = random(0, Constants.GRID_NUMBER - 1);
    int y = random(0, Constants.GRID_NUMBER - 1);
    int target = grid[x][y];
    List<String> oldPoints = [x.toString() + ',' + y.toString()];
    if (operator == Constants.PLUS) {
      target += generator(grid, counter - 1, x, y, oldPoints);
    } else if (operator == Constants.MULT) {
      target *= generator(grid, counter - 1, x, y, oldPoints);
    }

    return target;
  }

  static int generator(List<List<int>> grid, int counter, x, y, List<String> oldPoints) {
    if (counter == 0) {
      return 0;
    }
    int r1 = random(-1, 1);
    int r2 = random(-1, 1);
    if (x == 0) {
      r1 = 1;
    } else if (x == Constants.GRID_NUMBER - 1) {
      r1 = -1;
    }
    if (y == 0) {
      r2 = 1;
    } else if (y == Constants.GRID_NUMBER - 1) {
      r2 = -1;
    }
    int newX = x + r1, newY = y + r2;
    if (r1 == 0 && r2 == 0) {
      return generator(grid, counter, x, y, oldPoints);
    }
    if (oldPoints.contains(newX.toString() + ',' + newY.toString())) {
      return generator(grid, counter, x, y, oldPoints);
    } else {
      oldPoints.add(newX.toString() + ',' + newY.toString());
      return generator(grid, counter - 1, newX, newY, oldPoints) + grid[newX][newY];
    }
  }

  static bool isDraggedGrid(List<Tile> list, Tile tile) {
    for (int i = 0; i < list.length; i++) {
      if (tile.x == list[i].x && tile.y == list[i].y) return true;
    }
    return false;
  }

  static Tile draggedGridDetector(List<Tile> tiles, Offset position) {
    for (int i = 0; i < tiles.length; i++) {
      if (position.dx > tiles[i].getBounds()[2] && position.dx < tiles[i].getBounds()[3]) {
        if (position.dy > tiles[i].getBounds()[0] && position.dy < tiles[i].getBounds()[1]) {
          return tiles[i];
        }
      }
    }
    return null;
  }
}
