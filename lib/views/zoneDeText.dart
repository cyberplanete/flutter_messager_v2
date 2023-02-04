import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class ZoneDeText extends StatefulWidget {
  Utilisateur tchatUSer;
  String utilisateur;

  ZoneDeText({required this.tchatUSer, required this.utilisateur});

  @override
  ZoneDeTextState createState() => ZoneDeTextState();
}

class ZoneDeTextState extends State<ZoneDeText> {
  TextEditingController _textEditingController = TextEditingController();

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
            controller: _textEditingController,
            decoration:
                InputDecoration.collapsed(hintText: "Ecrivez un message"),
            maxLines: null, //Permet d'ecrire sur autant de ligne que necessaire
          )),
          IconButton(
              onPressed: () {
                sendMessageOnButtonPressed();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }

  void sendMessageOnButtonPressed() {
    if (_textEditingController.text.isNotEmpty) {
      String text = _textEditingController.text;
      //Envoyer sur firebase
      FirebaseController()
          .sendMessages(widget.utilisateur, widget.tchatUSer, text);
      _textEditingController.clear();
      FocusScope.of(context).requestFocus(
          FocusNode()); //Ferme le clavier apres l'envoi du message
    } else {
      //TODO Afficher un message d'erreur
    }
  }
}
