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

  static final entry_utilisateurs =
      FirebaseDatabase.instance.ref().child("utilisateurs");
  static final entry_messages =
      FirebaseDatabase.instance.ref().child("messages");
  static final entry_conversations =
      FirebaseDatabase.instance.ref().child("conversations");

  Future<String> myUserID() async {
    User user = auth.currentUser!;
    String id = user.uid;
    return id;
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
    entry_utilisateurs.child(utilisateurUid!).set(userData);
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
    // DataSnapshot snapshot = (await entry_utilisateurs.child(uid).once()).snapshot;
    // return new Utilisateur.fromSnapshot(snapshot);

    DataSnapshot dataSnapshot = await entry_utilisateurs.child(uid).get();
    return Utilisateur.fromSnapshot(dataSnapshot);
  }

  /// Fonction qui permet de stocker les messages dans la base de données de firebase
  sendMessages(Utilisateur? userReceiver, Utilisateur? currentUserSender,
      String message, String imageUrl) {
    //id1 et id2
    String ref = getMesssagesRef(currentUserSender?.uid, userReceiver?.uid);
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    Map messageMap = {
      "from": currentUserSender?.uid,
      "to": userReceiver?.uid,
      "message": message,
      "date": date,
      "imageUrl": imageUrl,
    };
    // Classement des message par ref et date
    entry_messages.child(ref).child(date).set(messageMap);

    // Notification du dernier message pour l'utilisateur courant sauvegardé dans la base de données de firebase
    entry_conversations
        .child(currentUserSender!.uid!)
        .child(userReceiver!.uid!)
        .set(setConversation(
            currentUserSender.uid, userReceiver, message, date));
    // Notification du dernier message pour l'utilisateur destinataire sauvegardé dans la base de données de firebase
    entry_conversations
        .child(userReceiver.uid!)
        .child(currentUserSender.uid!)
        .set(setConversation(
            currentUserSender.uid, currentUserSender, message, date));
  }

  setConversation(
      String? sender, Utilisateur user, String lastMessage, String date) {
    Map map = user.toMap();
    map["monId"] = sender;
    map["lastMessage"] = lastMessage;
    map["dateString"] = date;

    return map;
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
