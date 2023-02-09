import 'package:firebase_database/firebase_database.dart';

import 'Utilisateur.dart';

class Conversation {
  String? id;
  Utilisateur? user;
  String? avatar;
  String? lastMessage;
  String? lastMessageTime;
  int? unreadCount;

  Conversation({required DataSnapshot snapshot}) {
    var data = snapshot.value as Map?;
    user = Utilisateur.fromSnapshot(snapshot);
    if (data != null) {
      id = data["monId"];
      // TODO name = data["nom"];
      //TODO avatar = data["imageUrl"];
      lastMessage = data["lastMessage"];
      lastMessageTime = data["dateString"];

      // TODO  unreadCount = data["unreadCount"];
    }
  }
}
