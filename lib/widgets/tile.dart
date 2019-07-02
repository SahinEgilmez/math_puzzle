import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:math_puzzle/utils/util.dart';
import 'package:math_puzzle/utils/constants.dart';


class Tile extends StatefulWidget {
  _TileState state;
  String number;
  int x, y;
  Color color;
  double width, height, top, bottom, left, right, size;
  bool isSelected = false;

  Tile(this.number, this.width, this.height, this.color, this.size, this.x, this.y);

  @override
  State<StatefulWidget> createState() {
    state = _TileState();
    return state;
  }

  void changeColor(Color color) {
    this.color = color;
    state.changeColor(color);
  }
}

class _TileState extends State<Tile> {
  String num;
  int x, y;
  Color color;
  var globalKey = RectGetter.createGlobalKey();

  void initBounds(BuildContext context) {
    var rect = RectGetter.getRectFromKey(globalKey);
    print(x.toString() + "," + y.toString() + "" + rect.toString());
    double diff = rect.width / 5;
    widget.top = rect.top + diff;
    widget.bottom = rect.bottom - diff;
    widget.left = rect.left + diff;
    widget.right = rect.right - diff;
  }

  void changeColor(Color color) {
    setState(() {
      this.color = color;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBounds(context));
  }

  @override
  Widget build(BuildContext context) {
    num = widget.number;
    x = widget.x;
    y = widget.y;
    return new RectGetter(
      key: globalKey,
      child: new GestureDetector(
        onTap: () {},
        child: new Container(
          child: Center(
            child: Text(
              widget.number,
              style: TextStyle(fontSize: widget.size, fontWeight: FontWeight.bold, color: Constants.TRANSPARENT_WHITE),
            ),
          ),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.all(Radius.circular(30.0))),
        ),
      ),
    );
  }
}
