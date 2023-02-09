import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/tchatController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

import '../customImage.dart';

/// ContactsController est un widget qui permet de créer un contact avec un texte et une image
class ContactsController extends StatefulWidget {
  String? userSenderID;

  ContactsController({required String userSenderID}) {
    this.userSenderID = userSenderID;
  }

  @override
  _ContactsControllerState createState() => _ContactsControllerState();
}

class _ContactsControllerState extends State<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: FirebaseDatabase.instance
            .ref()
            .child("utilisateurs")
            .orderByChild("nom"),
        itemBuilder: (BuildContext context, DataSnapshot dataSnapshot,
            Animation<double> animation, int index) {
          Utilisateur partenaireDeTchat =
              new Utilisateur.fromSnapshot(dataSnapshot);

          if (partenaireDeTchat.uid != widget.userSenderID) {
            return ListTile(
              leading: CustomImage(
                  imageUrl: partenaireDeTchat.imageUrl,
                  initiales: partenaireDeTchat.initiales,
                  radius: 20),
              title: Text(partenaireDeTchat.fullName()),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new TchatController(
                                userSenderID: widget.userSenderID!,
                                user_receiver: partenaireDeTchat,
                              )));
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
