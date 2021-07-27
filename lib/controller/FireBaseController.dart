import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  ///Autorisation
  static final firebase_auth_instance = FirebaseAuth.instance;

  ///base de donnée utilisateur realtimeDatabase
  static final firestore_instance = FirebaseFirestore.instance;
  final firebase_firestore_collectionUtilisateurs =
      firestore_instance.collection("utilisateurs");

  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  /// Methode permettant la création du compte utilisateur sur Firebase
  Future<User?> creationDeCompte(
      String email, String mdp, String prenom, String nom) async {
    final create = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: mdp);
    final User? user = create.user;

    String utilisateurUid = user!.uid;
    Map<String, String> userData = {
      "uid": utilisateurUid,
      "nom": nom,
      "prenom": prenom,
      "email": email,
    };
    AddUser(utilisateurUid, userData);
    return user;
  }

  void AddUser(String utilisateurUid, Map<String, String> userData) {
    firebase_firestore_collectionUtilisateurs.doc(utilisateurUid).set(userData);
  }
}
