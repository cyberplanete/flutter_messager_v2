import 'package:flutter/material.dart';

/// MessageController est un widget qui permet de créer un message avec un texte et une image
class MessagesController extends StatefulWidget {
  const MessagesController({Key? key}) : super(key: key);

  @override
  _MessagesControllerState createState() => _MessagesControllerState();
}

class _MessagesControllerState extends State<MessagesController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Messages"),
    );
  }
}
