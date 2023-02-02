import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class ZoneDeText extends StatefulWidget {
  Utilisateur tchatUSer;

  ZoneDeText({required this.tchatUSer});

  @override
  ZoneDeTextState createState() => ZoneDeTextState();
}

class ZoneDeTextState extends State<ZoneDeText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(3.5),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_enhance)),
          IconButton(onPressed: () {}, icon: Icon(Icons.photo_library)),
          Flexible(
              child: TextField(
            decoration:
                InputDecoration.collapsed(hintText: "Ecrivez un message"),
            maxLines: null, //Permet d'ecrire sur autant de ligne que necessaire
          )),
          IconButton(onPressed: () {}, icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
