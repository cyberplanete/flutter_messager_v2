import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class FirebaseController {
  ///Autorisation avec FireAuth
  final firebase_auth_instance = FirebaseAuth.instance;

  ///Autorisation avec FireDatabase

  static final entry_user =
      FirebaseDatabase.instance.reference().child("utilisateurs");
  //final entry_user = entryPoint.child("utilisateurs");

  ///base de donnée utilisateur realtimeDatabase
  static final firestore_instance = FirebaseFirestore.instance;
  final firebase_collectionUtilisateurs =
      firestore_instance.collection("utilisateurs");

  /// Methode permettant la création du compte utilisateur sur Firebase
  Future<User?> creationDeCompte(String email, String mdp, String prenom,
      String nom, String imageUrl) async {
    final create = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: mdp);
    final User? user = create.user;

    String utilisateurUid = user!.uid;
    Map<String, String> userData = {
      "uid": utilisateurUid,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "imageUrl": imageUrl,
    };
    AddUser(utilisateurUid, userData);
    return user;
  }

  /// Ajouter un utilisateur dans la base de données de Firebase
  void AddUser(String utilisateurUid, Map<String, String> userData) {
    firebase_collectionUtilisateurs.doc(utilisateurUid).set(userData);
  }

  /// Connecter un utilisateur à la base de données Firebase
  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  Future<Utilisateur> getUtilisateur(String uid) async {
    DocumentSnapshot snapshot =
        await firebase_collectionUtilisateurs.doc(uid).get();
    Utilisateur utilisateur = Utilisateur(snapshot);
    return utilisateur;
  }
}
