import 'package:flutter/material.dart';

class DataArea extends StatefulWidget {
  final DataAreaScene state = DataAreaScene();
  final String title;
  final Color color;

  DataArea(this.title, this.color);

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  int getData() => state.data;

  void changeData(int data) => state.update(data);

  void addToData(int data)  => state.update(data + state.data);
}

class DataAreaScene extends State<DataArea> {
  int data = 0;

  DataAreaScene();

  void update(int data) {
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.color,
        ),
        child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 15.0, color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  '$data',
                  style: TextStyle(fontSize: 30.0, color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              )
            ])));
  }
}
