import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:math_puzzle/utils/constants.dart';

class Tile extends StatefulWidget {
  final TileState state = TileState();
  final int x, y;
  final double width, height, size;
  final String initNumber;
  final Color initColor;

  Tile(this.initNumber, this.width, this.height, this.initColor, this.size, this.x, this.y);

  @override
  State<StatefulWidget> createState() => state;

  void changeColor(Color color) => state.changeColor(color);

  void changeNumber(String number) => state.changeNumber(number);

  String getNumber() => state.number;

  Color getColor() => state.color;

  List getBounds() {
    double diff = state.tileRect.width / 10;
    return [state.tileRect.top + diff, state.tileRect.bottom - diff, state.tileRect.left + diff, state.tileRect.right - diff];
  }
}

class TileState extends State<Tile> {
  String number;
  Color color;
  Rect tileRect;
  GlobalKey globalKey = RectGetter.createGlobalKey();

  void changeColor(Color color) => setState(() => this.color = color);

  void changeNumber(String number) => setState(() => this.number = number);

  void initBounds() => tileRect = RectGetter.getRectFromKey(globalKey);

  @override
  void initState() {
    super.initState();
    number = widget.initNumber;
    color = widget.initColor;
    WidgetsBinding.instance.addPostFrameCallback((_) => initBounds());
  }

  @override
  Widget build(BuildContext context) {
    return new RectGetter(
      key: globalKey,
      child: new GestureDetector(
        onTap: () {},
        child: new Container(
          child: Center(
            child: Text(
              this.number,
              style: TextStyle(fontSize: widget.size, fontWeight: FontWeight.bold, color: Constants.TRANSPARENT_WHITE),
            ),
          ),
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(color: this.color, borderRadius: BorderRadius.all(Radius.circular(30.0))),
        ),
      ),
    );
  }
}
