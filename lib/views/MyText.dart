import 'package:flutter/material.dart';

class MyText extends Text {
  final String dataText;
  final TextAlign textAlignment;
  final double fontSize;
  final FontStyle fontStyle;
  final Color color;

  MyText(
      {required this.dataText,
      this.textAlignment = TextAlign.center,
      this.fontStyle = FontStyle.normal,
      this.color = Colors.white,
      this.fontSize = 17.0})
      : super(dataText,
            textAlign: textAlignment,
            style: TextStyle(
                fontSize: fontSize, fontStyle: fontStyle, color: color));
}
