import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/customImage.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';
import 'package:flutter_messager_v2/views/zoneDeTextMeesage.dart';

class TchatController extends StatefulWidget {
  Utilisateur tchatUser;
  String id;

  TchatController({required this.tchatUser, required this.id});

  @override
  TchatControllerState createState() => TchatControllerState();
}

class TchatControllerState extends State<TchatController> {
  String messages = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(
                  //TODO Modifier custom image pour être visible dans l'appbar
                  imageUrl: widget.tchatUser.imageUrl,
                  initiales: widget.tchatUser.initiales,
                  radius: 20),
              Text(widget.tchatUser.fullName()),
            ],
          ),
        ),
        body: InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          // Permet de cacher le clavier lorsqu'on clique ailleurs que sur le clavier
          child: Column(
            children: [
              Flexible(
                child: (widget.id != null)
                    ? FirebaseAnimatedList(
                        query: FirebaseController.messagesCollection.child(
                            FirebaseController().getMesssagesRef(
                                widget.id, widget.tchatUser.uid)),
                        itemBuilder: (BuildContext buildContext,
                            DataSnapshot dataSnapshot,
                            Animation<double> animation,
                            int index) {
                          final map =
                              dataSnapshot.value as Map<dynamic, dynamic>;
                          if (dataSnapshot.value != null) {
                            messages = map['Message'].toString();
                          }
                          return ListTile(
                            title: Text(messages),
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Divider(
                height: 2,
              ),
              ZoneDeTextMessage(
                tchatUSer: widget.tchatUser,
                utilisateur: widget.id,
              )
            ],
          ),
        ));
  }
}
