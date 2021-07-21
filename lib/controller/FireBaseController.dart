import 'package:firebase_auth/firebase_auth.dart';

class FirebaseController {
  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  Future<User?> creationDeCompte(
      String email, String mdp, String prenom, String nom) async {
    final UserCredential create = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: mdp);
    return create.user;
  }
}
