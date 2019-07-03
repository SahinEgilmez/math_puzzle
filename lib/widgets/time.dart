import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/utils/constants.dart';

class TimeRemainer extends StatefulWidget {
  _TimeRemainer state;
  double percent;
  bool gameOver;
  Timer timer;

  TimeRemainer(double percent) {
    this.percent = percent;
    this.gameOver = false;
    timer = Timer.periodic(Constants.SECOND, (Timer t) => this.periodicTimer());
  }

  @override
  State<StatefulWidget> createState() {
    state = _TimeRemainer(percent);
    return state;
  }

  void periodicTimer() {
    if (percent < Util.period) {
      gameOver = true;
    } else {
      gameOver = false;
      changePercent(percent - Util.period);
    }
  }

  void changePercent(double percent) {
    this.percent = percent;
    state.changePercent(percent);
  }
}

class _TimeRemainer extends State<TimeRemainer> {
  double timePercent;

  _TimeRemainer(double time) {
    timePercent = time;
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
