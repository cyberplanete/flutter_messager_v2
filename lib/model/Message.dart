import 'package:firebase_database/firebase_database.dart';

class Message {
  String? from;
  String? to;
  String? message;
  String? dateString;

  Message({required DataSnapshot snapshot}) {
    Map map = snapshot.value as Map;
    from = map["From"];
    to = map["To"];
    message = map["Message"];
    dateString = map["time"];
  }
}
