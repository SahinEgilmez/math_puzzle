import 'package:flutter/material.dart';

class Constants {
  static const Duration SECOND = Duration(seconds: 1);
  static const PLUS = "ADDITION";
  static const MULT = "MULTIPLICATION";
  static const GRID_NUMBER = 4;
  static const BACKGROUND_COLOR = Color.fromARGB(255, 243, 241, 239);
  static const GAME_OVER_COLOR = Color.fromARGB(255, 207, 0, 15);
  static const EMPTY_GRID_COLOR = Color.fromARGB(255, 103, 65, 114);
  static const GRID_WIN_COLOR = Color.fromARGB(255, 247, 202, 24);
  static const AREA_COLOR = Color.fromARGB(255, 51, 110, 123);
  static const TRANSPARENT_WHITE = Colors.white;
  static const String ADMOB_APP_ID = "ca-app-pub-5102346463770175~2100343794";
  static const String GAME_INFO = "There are 2 different modes in the game. These are addition (+) and multiplication (×) operations. "
      "The goal is to reach the target number given in the game before the time has elapsed by using the operation in the mode of your choice. "
      "When the number reaches the target, this number is added to the score. You need to know every number before it runs out. "
      "The time to reach the goal is initially 100 seconds, and as long as you score, this time will be reduced to 10 seconds and the game will be difficult. "
      "\nShow off your math knowledge!";
  static const String DEVELOPER_INFO =
      "This game was created by Şahin Eğilmez(@FalconInflexible). Flutter SDK and Dart Programming language were used in the development phase. "
      "If you like the game, don't forget to give points and comment.";
}
