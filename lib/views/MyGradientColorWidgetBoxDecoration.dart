import 'package:flutter/material.dart';

class MyGradientColorWidgetBoxDecoration extends BoxDecoration {
  ///represents the top left x
  static final FractionalOffset beginHorizontalLeft = FractionalOffset(00, 00);

  ///represents the top right x
  static final FractionalOffset endHorizontalRight = FractionalOffset(01, 00);

  ///represents the bottom left
  static final FractionalOffset endVerticalLeft = FractionalOffset(00, 01);

  final Color startColor;
  final Color endColor;
  final bool isHorizontal;
  final double radius;
  MyGradientColorWidgetBoxDecoration(
      {required this.startColor,
      required this.endColor,
      this.isHorizontal = false,
      this.radius = 0.0})
      : super(
          ///Dégradé avec début et fin de couleur /// Dégrade sur l'horizontal
          gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: beginHorizontalLeft,
              end: (isHorizontal) ? endHorizontalRight : endVerticalLeft),
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        );
}
