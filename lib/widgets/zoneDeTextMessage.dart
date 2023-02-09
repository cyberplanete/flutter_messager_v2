import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class ZoneDeTextMessage extends StatefulWidget {
  Utilisateur? user_receiver;
  String? userSenderID;

  ZoneDeTextMessage({required user_receiver , required String this.userSenderID})
  {
    this.userSenderID = userSenderID;
    this.user_receiver = user_receiver;

  }

  ZoneDeTextMessageState createState() => new ZoneDeTextMessageState();
}

class ZoneDeTextMessageState extends State<ZoneDeTextMessage> {
  TextEditingController _textEditingController = TextEditingController();
  Utilisateur? userSender;



  @override
  void initState() {
    super.initState();
    FirebaseController().getUtilisateur(widget.userSenderID!).then((value) {
      setState(() {
        userSender = value;
      });
    });

  }


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
    if (_textEditingController.text != null) {
      String text = _textEditingController.text;

      //Envoyer sur firebase
      FirebaseController()
          .sendMessages(widget.user_receiver,userSender , text, widget.user_receiver?.imageUrl??"");
      _textEditingController.clear();
      FocusScope.of(context).requestFocus(
          FocusNode()); //Ferme le clavier apres l'envoi du message
    } else {
      //TODO Afficher un message d'erreur
    }
  }
}
