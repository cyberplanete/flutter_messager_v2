import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseController {
  ///Autorisation
  static final firebase_realtime_instance =
      FirebaseDatabase.instance.reference();

  ///base de donnée utilisateur realtimeDatabase
  final firebase_realtime_collectionUtilisateurs =
      firebase_realtime_instance.child("utilisateurs");

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
    User user = create.user!;
    String utilisateurUid = user.uid;
    Map<String, dynamic> userData = {
      "uid": utilisateurUid,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "mdp": mdp,
    };
    firebase_realtime_collectionUtilisateurs
        .child(utilisateurUid)
        .set(userData);
    return user;
  }
}
