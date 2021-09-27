import 'package:flutter/cupertino.dart';

class MyPaddingCustomWith extends Padding {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final Widget? unWidget;
  MyPaddingCustomWith(
      {@required this.unWidget,
      this.top = 10.0,
      this.right = 0,
      this.left = 0,
      this.bottom = 0})
      : super(
            padding: EdgeInsets.only(
                top: top, right: right, left: left, bottom: bottom),
            child: unWidget);
}
