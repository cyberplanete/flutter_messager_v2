import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/customImage.dart';
import 'package:flutter_messager_v2/model/Message.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';
import 'package:flutter_messager_v2/widgets/zoneDeTextMessage.dart';

import '../widgets/chatBuble.dart';

class TchatController extends StatefulWidget {
  Utilisateur? user_receiver;
  String? userSenderID;

  TchatController(
      {required Utilisateur? user_receiver, required String userSenderID}) {
    this.user_receiver = user_receiver;
    this.userSenderID = userSenderID;
  }

  TchatControllerState createState() => TchatControllerState();
}

class TchatControllerState extends State<TchatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                  //TODO Modifier custom image pour être visible dans l'appbar
                  imageUrl: widget.user_receiver?.imageUrl,
                  initiales: widget.user_receiver?.initiales,
                  radius: 20),
              Text(widget.user_receiver!.fullName()),
            ],
          ),
        ),
        body: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          // Permet de cacher le clavier lorsqu'on clique ailleurs que sur le clavier
          child: Column(
            children: [
              Flexible(
                  child: FirebaseAnimatedList(
                      reverse: true,
                      query: FirebaseController.entry_messages.child(
                          FirebaseController().getMesssagesRef(
                              widget.userSenderID, widget.user_receiver!.uid)),
                      itemBuilder: (BuildContext buildContext,
                          DataSnapshot dataSnapshot,
                          Animation<double> animation,
                          int index) {
                        Message msg = Message(snapshot: dataSnapshot);
                        print(msg.message);
                        return new ChatBubble(widget.userSenderID!,
                            widget.user_receiver!, msg, animation);
                      })),
              Divider(
                height: 2,
              ),
              ZoneDeTextMessage(
                user_receiver: widget.user_receiver,
                userSenderID: widget.userSenderID!,
              )
            ],
          ),
        ));
  }
}
