import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/controller/tchatController.dart';
import 'package:flutter_messager_v2/customImage.dart';
import 'package:flutter_messager_v2/model/Conversations.dart';

import '../model/Utilisateur.dart';

/// MessageController est un widget qui permet de créer un message avec un texte et une image
class MessagesController extends StatefulWidget {
  String? userSenderID;

  MessagesController({required String userSenderID}) {
    this.userSenderID = userSenderID;
  }

  @override
  _MessagesControllerState createState() => _MessagesControllerState();
}

class _MessagesControllerState extends State<MessagesController> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseController.auth.currentUser!.uid;
    return Center(
      child: FirebaseAnimatedList(
        query: FirebaseController.entry_conversations.child(uid),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Conversation conversation = Conversation(snapshot: snapshot);
          String sub = (conversation.id == widget.userSenderID) ? "Moi" : "";
          sub += " : " + conversation.lastMessage!;
          return ListTile(
            leading: CustomImage(
              imageUrl: conversation.user?.imageUrl,
              initiales: conversation.user?.initiales,
              radius: 20,
            ),
            title: Text(conversation.user!.fullName()),
            subtitle: Text(sub),
            trailing: Text(conversation.lastMessageTime!),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext buildContext) {
                return TchatController(
                    userSenderID: widget.userSenderID!,
                    user_receiver: conversation.user!);
              }));
            },
          );
        },
      ),
    );
  }
}
