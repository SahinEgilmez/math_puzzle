import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_puzzle/widgets/tile.dart';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/utils/constants.dart';

class Functions {
  static List<List<int>> blankGrid() {
    List<List<int>> rows = [];
    for (int i = 0; i < Constants.GRID_NUMBER; i++) {
      rows.add([gridNumGenerator(rows), gridNumGenerator(rows), gridNumGenerator(rows), gridNumGenerator(rows)]);
    }
    return rows;
  }

  static int gridNumGenerator(List<List<int>> rows) {
    int rnd = 1;
    rnd = random(Util.min, Util.max);
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
    if (Util.operator == Constants.PLUS) {
      target += generator(grid, counter - 1, x, y, oldPoints);
    } else if (Util.operator == Constants.MULT) {
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
      if (position.dx > tiles[i].left && position.dx < tiles[i].right) {
        if (position.dy > tiles[i].top && position.dy < tiles[i].bottom) {
          return tiles[i];
        }
      }
    }
  }
}
