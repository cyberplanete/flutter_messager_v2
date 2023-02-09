import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messager_v2/controller/DateController.dart';

class Message {
  String? from;
  String? to;
  String? message;
  String? imageUrl;
  String date = "";

  Message({required DataSnapshot snapshot}) {
    Map map = snapshot.value as Map;
    from = map["from"];
    to = map["to"];
    message = map["message"];
    String date = map["date"];
    date = DateController().getDate(date);
    imageUrl = map["imageUrl"];
  }
}
