import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class ProfilesController extends StatefulWidget {
  const ProfilesController({Key? key}) : super(key: key);

  @override
  _ProfilesControllerState createState() => _ProfilesControllerState();
}

/// _ProfilesControllerState est un widget qui permet de créer un profil avec un texte et une image
class _ProfilesControllerState extends State<ProfilesController> {
  Utilisateur? utilisateur;
  // par défaut, l'utilisateur est connecté (true) ou non (false). bool _isUserConnected = true;
  User? currentUser = FirebaseController().firebase_auth_instance.currentUser;
  String? prenom;
  String? nom;

  @override
  void initState() {
    super.initState();
    _getUserProfile(); // Récupération du profil de l'utilisateur
  }

  @override
  Widget build(BuildContext context) {
    return (utilisateur == null)
        ? Center(
            child: Text("Chargement ..."), // Texte affiché lors du chargement du profil
          )
        : SingleChildScrollView(
            // Permet de scroller la page
            child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: utilisateur?.prenom),
                  onChanged: (str) {
                    setState(() {
                      prenom = str;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: utilisateur?.nom),
                  onChanged: (str) {
                    setState(() {
                      nom = str;
                    });
                  },
                ),
                ElevatedButton(child: Text("Sauvegarder"), onPressed: saveChanges),
                TextButton(
                    child: Text("Se déconnecter"),
                    onPressed: () {
                      logOut();
                    })
              ],
            ),
          ));
  }

  /// Se déconnecte de l'application et retourne à la page d'authentification
  Future<void> logOut() async {
    Text titre = Text("Se déconnecter");
    Text contenant = Text("Etes vous sur de vouloir vous deconnecter ?");
    ElevatedButton noBtn = ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(); // Retourne à la page précédente
        },
        child: Text("non"));
    ElevatedButton yesBtn = ElevatedButton(
        onPressed: () {
          FirebaseController().seDeconnecter().then((bool) => Navigator.of(context).pop()); // Se déconnecte de l'application
        },
        child: Text("oui"));
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: titre,
                  content: contenant,
                  actions: [yesBtn, noBtn],
                )
              : AlertDialog(
                  title: titre,
                  content: contenant,
                  actions: [yesBtn, noBtn],
                );
        });
  }

  /// Fonction qui permet de sauvegarder les modifications du profil
  saveChanges() {
    Map<String, String?> map = utilisateur!.toMap(); // Récupération des données du profil
    if (prenom != null && prenom != "") {
      map["prenom"] = prenom!;
    }
    if (nom != null && nom != "") {
      map["nom"] = nom!;
    }
    FirebaseController().AddOrModifyUser(utilisateur!.uid, map);
    _getUserProfile();
  }

  /// _getUserProfile permet de récupérer les informations de l'utilisateur connecté et de les afficher dans le widget ProfileController
  _getUserProfile() {
    FirebaseController().getUtilisateur(currentUser!.uid).then((value) {
      setState(() {
        this.utilisateur = value;
      });
    });
  }
}
