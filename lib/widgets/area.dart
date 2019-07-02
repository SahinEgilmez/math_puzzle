import 'package:flutter/material.dart';

class DataArea extends StatefulWidget {
  _DataArea state;
  int data;
  String title;
  Color color;

  DataArea(this.title, this.data,this.color);

  @override
  State<StatefulWidget> createState() {
    state = _DataArea(title, data,color);
    return state;
  }

  void changeData(data) {
    this.data = data;
    state.setData(data);
  }

  void addToData(data) {
    this.data += data;
    state.setData(this.data);
  }
}

class _DataArea extends State<DataArea> {
  String title;
  int data;
  Color color;

  _DataArea(this.title, this.data,this.color);

  void setData(data) {
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
          color: this.color,
        ),
        child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  this.title,
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
