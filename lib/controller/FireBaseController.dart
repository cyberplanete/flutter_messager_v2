import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  ///Autorisation
  static final firestore_instance = FirebaseFirestore.instance;

  ///base de donnée utilisateur
  final fireStore_collectionUtilisateurs =
      firestore_instance.collection("utilisateurs");

  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  /// Methode permettant la création du compte utilisateur sur Firebase
  Future<User?> creationDeCompte(
      String email, String mdp, String prenom, String nom) async {
    final UserCredential create = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: mdp);
    String utilisateurUid = create.user!.uid;
    Map<String, dynamic> userData = {
      "uid": utilisateurUid,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "mdp": mdp,
    };
    fireStore_collectionUtilisateurs.doc(utilisateurUid).set(userData);
    return create.user;
  }
}
