import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/customImage.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';
import 'package:flutter_messager_v2/views/zoneDeText.dart';

class TchatController extends StatefulWidget {
  Utilisateur tchatUser;

  TchatController({required this.tchatUser});

  @override
  TchatControllerState createState() => TchatControllerState();
}

class TchatControllerState extends State<TchatController> {
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
                  child: Container(
                color: Colors.red,
              )),
              Divider(
                height: 2,
              ),
              ZoneDeText(tchatUSer: widget.tchatUser)
            ],
          ),
        ));
  }
}
