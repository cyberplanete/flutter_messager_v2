import 'package:flutter/material.dart';

import 'MyGradientColorWidgetBoxDecoration.dart';
import 'MyText.dart';
import 'constants.dart';

class MyButtonGradient extends Card {
  double elevation;
  VoidCallback callback;
  double width;
  double height;
  String texte;
  MyButtonGradient({this.elevation: 7.5, required this.callback, this.width: 300, this.height: 50, required this.texte})
      : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            width: width,
            height: height,
            decoration: MyGradientColorWidgetBoxDecoration(startColor: cColorBase, endColor: cColorBaseAccent, radius: 25, isHorizontal: true),
            child: TextButton(
              onPressed: callback,
              child: MyText(dataText: texte),
            ),
          ),
        );
}
