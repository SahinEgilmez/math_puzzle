import 'package:flutter/material.dart';
import 'package:math_puzzle/utils/engine.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:math_puzzle/utils/constants.dart';

class TimeRemainer extends StatefulWidget {
  final _TimeRemainerState state = _TimeRemainerState();

  TimeRemainer(double percentT);

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  bool isGameOver() => state.gameOver;

  void timerCancel() => state.timer.cancel();

  void changePercent(double percent) {
    percent = percent;
    state.changePercent(percent);
  }
}

class _TimeRemainerState extends State<TimeRemainer> {
  double timePercent;
  bool gameOver;
  Timer timer;

  _TimeRemainerState() {
    timePercent = 1.0;
    gameOver = false;
    timer = Timer.periodic(Constants.SECOND, (Timer t) => periodicTimer());
  }

  void periodicTimer() {
    if (this.mounted) {
      if (timePercent < Engine.period) {
        gameOver = true;
      } else {
        gameOver = false;
        changePercent(timePercent - Engine.period);
      }
    }
  }

  void changePercent(double percent) {
    setState(() {
      timePercent = percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      alignment: MainAxisAlignment.center,
      width: 300,
      lineHeight: 10,
      percent: timePercent,
    );
  }
}
