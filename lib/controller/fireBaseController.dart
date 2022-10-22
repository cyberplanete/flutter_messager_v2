import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

/// Classe de gestion de Firebase pour les messages et les utilisateurs de l'application de messagerie instantanée
class FirebaseController {
  // Instance de la base de données de firebase (Cloud Firestore)
  final firebase_auth_instance = FirebaseAuth.instance;

  // On récupère les utilisateurs de la base de données de firebase (Cloud Firestore)
  static final entry_user = FirebaseDatabase.instance.ref().child("utilisateurs");
  static final firestore_instance = FirebaseFirestore.instance;
  final firebase_collectionUtilisateurs = firestore_instance.collection("utilisateurs");

  /// Fonction qui permet de créer un utilisateur dans la base de données de firebase
  Future<User?> creationDeCompte(String email, String mdp, String prenom, String nom, String imageUrl) async {
    // Création de l'utilisateur dans la base de données de firebase
    final create = await firebase_auth_instance.createUserWithEmailAndPassword(email: email, password: mdp);
    // Récupération de l'utilisateur
    final User? user = create.user;
    // Récupération de l'uid de l'utilisateur
    String utilisateurUid = user!.uid;
    // Création d'un utilisateur dans la base de données de firebase
    Map<String, String> userData = {
      "uid": utilisateurUid,
      "nom": nom,
      "prenom": prenom,
      "adresseEmail": email,
      "imageUrl": imageUrl,
    };
    // Ajout ou modification de l'utilisateur dans la base de données de firebase
    AddOrModifyUser(utilisateurUid, userData);
    return user; // Retour de l'utilisateur
  }

  /// Ajouter ou modifier un utilisateur dans la base de données de Firebase
  void AddOrModifyUser(String utilisateurUid, Map<String, String?> userData) {
    firebase_collectionUtilisateurs.doc(utilisateurUid).set(userData);
  }

  /// Fonction qui permet de se connecter à un compte utilisateur
  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  /// Fonction qui permet de se déconnecter d'un compte utilisateur
  Future<bool> seDeconnecter() async {
    return firebase_auth_instance.signOut().then((value) => true);
  }

  /// Fonction qui permet de récupérer un utilisateur dans la base de données de firebase
  Future<Utilisateur> getUtilisateur(String uid) async {
    DocumentSnapshot snapshot = await firebase_collectionUtilisateurs.doc(uid).get();
    Utilisateur utilisateur = Utilisateur(snapshot);
    return utilisateur;
  }
}
