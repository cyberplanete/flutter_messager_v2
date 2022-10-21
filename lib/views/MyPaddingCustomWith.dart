import 'package:flutter/cupertino.dart';

/// Un widget qui permet de créer un padding personnalisé avec une largeur et une hauteur fixe
class MyPaddingCustomView extends Padding {
  final double top;
  final double left;
  final double right;
  final double bottom;
  final Widget? unWidget;
  MyPaddingCustomView(
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
