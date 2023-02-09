import 'package:flutter/material.dart';

import '../customImage.dart';
import '../model/Message.dart';
import '../model/Utilisateur.dart';

class ChatBubble extends StatefulWidget {
  Message? message;
  Utilisateur? userReceiver;
  String? currentUserID;
  Animation<double>? animation;

  ChatBubble(String id, Utilisateur partenaire, Message message,
      Animation<double> animation) {
    this.message = message;
    this.userReceiver = partenaire;
    this.currentUserID = id;
    this.animation = animation;
  }

  @override
  ChatBubbleState createState() => ChatBubbleState();
}

class ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: widget.animation!, curve: Curves.easeIn),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widgetsBubble(widget.message?.from == widget.currentUserID),
        ),
      ),
    );
  }

  List<Widget> widgetsBubble(bool isCurrentUser) {
    CrossAxisAlignment alignement =
        (isCurrentUser) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color? bubbleColor = (isCurrentUser) ? Colors.pink[100] : Colors.blue[400];
    Color? textColor = (isCurrentUser) ? Colors.black : Colors.grey[200];

    return <Widget>[
      isCurrentUser
          ? Padding(padding: EdgeInsets.all(8.0))
          : CustomImage(
              imageUrl: widget.userReceiver?.imageUrl,
              initiales: widget.userReceiver?.initiales,
              radius: 15,
            ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignement,
        children: <Widget>[
          Text(widget.message?.date ?? "",
              style: TextStyle(
                  color: textColor,
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic)),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: bubbleColor,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: (widget.message?.imageUrl == "")
                  ? Text(
                      widget.message?.message ?? "",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15.0,
                          fontStyle: FontStyle.italic),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomImage(
                            imageUrl: widget.message?.imageUrl,
                            initiales: null,
                            radius: 15),
                        Text(" "),
                        Text(
                          //Aligner à droite
                          widget.message?.message ?? "",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 15.0,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
            ),
          )
        ],
      ))
    ];
  }
}
