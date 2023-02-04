import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

/// Classe de gestion de Firebase pour les messages et les utilisateurs de l'application de messagerie instantanée
class FirebaseController {
  // Instance de la base de données de firebase (Cloud Firestore)
  static final auth = FirebaseAuth.instance;

  // On récupère les utilisateurs de la base de données de firebase (Cloud Firestore)

  static final utilisateursCollection =
      FirebaseDatabase.instance.ref().child("utilisateurs");
  static final messagesCollection =
      FirebaseDatabase.instance.ref().child("messages");

  Future<String?> myId() async {
    User? user = await auth.currentUser;
    return user?.uid;
  }

  /// Fonction qui permet de créer un utilisateur dans la base de données de firebase
  Future<User?> creationDeCompte(String email, String mdp, String prenom,
      String nom, String imageUrl) async {
    // Création de l'utilisateur dans la base de données de firebase
    final create =
        await auth.createUserWithEmailAndPassword(email: email, password: mdp);
    // On récupère l'utilisateur créé dans la base de données de firebase (Cloud Firestore)
    final User? user = create.user;
    // On vérifie que l'utilisateur n'est pas null
    String utilisateurUid = user!.uid;
    // on crée un objet utilisateur avec les informations de l'utilisateur
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
  void AddOrModifyUser(String? utilisateurUid, Map<String, String?> userData) {
    utilisateursCollection.child(utilisateurUid!).set(userData);
  }

  /// Fonction qui permet de se connecter à un compte utilisateur
  Future<User?> seConnecter(String mail, String mdp) async {
    final UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: mdp);
    return user.user;
  }

  /// Fonction qui permet de se déconnecter d'un compte utilisateur
  Future<bool> seDeconnecter() async {
    return auth.signOut().then((value) => true);
  }

  /// Fonction qui permet de récupérer un utilisateur dans la base de données de firebase
  Future<Utilisateur> getUtilisateur(String uid) async {
    DataSnapshot snapshot = await utilisateursCollection.child(uid).get();
    Utilisateur utilisateur = Utilisateur.fromSnapshot(snapshot);
    return utilisateur;
  }

  /// Fonction qui permet de stocker les messages dans la base de données de firebase
  sendMessages(String utilisateurId, Utilisateur tchatUser, String message) {
    //id1 et id2
    String ref = getMesssagesRef(utilisateurId, tchatUser.uid);
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    Map messageMap = {
      "From": utilisateurId,
      "To": tchatUser.uid,
      "Message": message,
      "Time": date,
    };
    // Classement des message par ref et date
    messagesCollection.child(ref).child(date).set(messageMap);
  }

  /// Fonction qui permet la reference des conversations entre les utilisateurs
  getMesssagesRef(String? from, String? to) {
    List<String?> ids = [from, to];
    ids.sort((a, b) => a!.compareTo(b!)); //sort les ids par ordre alphabétique
    String ref = "";
    for (var x in ids) {
      ref += (x! + "_");
    }
    ;
    return ref;
  }

  static final entryCollection = FirebaseStorage.instance.ref();
  final storageUsers = entryCollection.child("users");

  // On sauvegarde l'image dans le storage de firebase
  Future<String?> savePicture(File image, Reference userReference) async {
    UploadTask uploadTask = userReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

//On recupère la liste des utilisateurs dataSnapshot

}
