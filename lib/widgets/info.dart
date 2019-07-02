import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoPage();
  }
}

class _InfoPage extends State<InfoPage> {
  String gameInfo =
      "\nThere are 2 different modes in the game. These are addition (+) and multiplication (×) operations. "
      "The goal is to reach the target number given in the game before the time has elapsed by using the operation in the mode of your choice. "
      "When the number reaches the target, this number is added to the score. You need to know every number before it runs out. "
      "The time to reach the goal is initially 100 seconds, and as long as you score, this time will be reduced to 10 seconds and the game will be difficult. "
      "\nShow off your math knowledge!\n\nŞahin Eğilmez\n@FalconInflexible";
  String sign = "Şahin Eğilmez\n(@FalconInflexible)";
  String developerInfo =
      "Bu oyun Şahin Eğilmez tarafından yaratılmıştır. Geliştirme aşamasında Flutter SDK ve Dart kullanılmıştır."
      "Oyunu beğendiyseniz puan vermeyi ve yorum yapmayı unutmayınız. ";

  _InfoPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Container(
          child: Center(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(this.gameInfo, textAlign: TextAlign.left, style: TextStyle(color: Colors.black87, fontSize: 20.0)),
              //Text(this.developerInfo, textAlign: TextAlign.left, style: TextStyle(color: Colors.black87, fontSize: 20.0))
            ],
          )),
        ),
      ),
    );
  }
}
