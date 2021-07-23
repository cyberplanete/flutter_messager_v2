import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Utilisateur {
  String? uid;
  String? prenom;
  String? nom;
  String? imageUrl;
  String? adresseEmail;
  String? initiales;

  /// recupéation depuis firestore
  Utilisateur(AsyncSnapshot documentSnapshot) {
    Map<String, dynamic> listUtilisateurs = documentSnapshot.data;
    this.uid = listUtilisateurs[uid];
    this.prenom = listUtilisateurs[prenom];
    this.imageUrl = listUtilisateurs[imageUrl];
    this.nom = listUtilisateurs[nom];
    this.adresseEmail = listUtilisateurs[adresseEmail];
    if (prenom != null && nom != null) {
      if (prenom!.length > 0 && nom!.length > 0) {
        this.initiales = prenom![0] + nom![0];
        this.initiales = listUtilisateurs[initiales];
      }
    } else {
      this.initiales = '';
    }
  }

  /// vers firestore
  Map toMap() {
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
