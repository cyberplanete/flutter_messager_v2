import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  String uid = "";
  String prenom = "";
  String nom = "";
  String imageUrl = "";
  String adresseEmail = "";
  String initiales = "";

  /// recupération depuis firebaseRealtime
  Utilisateur(DocumentSnapshot snapshot) {
    DocumentSnapshot<Object?> map = snapshot;

    this.uid = map.get("uid");
    this.prenom = map.get("prenom");
    this.imageUrl = map.get("imageUrl");
    this.nom = map.get("nom");
    this.adresseEmail = map.get("adresseEmail");
    if (prenom != null && nom != null) {
      if (prenom.length > 0 && nom.length > 0) {
        this.initiales = prenom[0] + nom[0];
        //this.initiales = map.get("initiales");
      }
    } else {
      this.initiales = '';
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
