import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Utilisateur {
  String uid = "";
  String prenom = "";
  String nom = "";
  String imageUrl = "";
  String adresseEmail = "";
  String initiales = "";

  Utilisateur.fromSnapshot(DataSnapshot snapshot) {
    var data = snapshot.value as Map?;
    if (data != null) {
      uid = data["uid"];
      prenom = data["prenom"];
      nom = data["nom"];
      imageUrl = data["imageUrl"];
      adresseEmail = data["adresseEmail"];
      if (prenom != null && nom != null) {
        if (prenom.length > 0 && nom.length > 0) {
          this.initiales = prenom[0] + nom[0];
          //this.initiales = map.get("initiales");
        }
      } else {
        this.initiales = '';
      }
    }
  }

  /// Map pour la base de données de firebase (Cloud Firestore) et la base de données de firebase (Realtime Database)
  Map<String, String?> toMap() {
    return {
      "uid": uid,
      "prenom": prenom,
      "nom": nom,
      "adresseEmail": adresseEmail,
      "imageUrl": imageUrl,
      "initiales": initiales,
    };
  }
}
