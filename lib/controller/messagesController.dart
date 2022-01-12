import 'package:flutter/material.dart';

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
