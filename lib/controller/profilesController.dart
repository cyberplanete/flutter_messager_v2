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

//TODO pull to refresh
class _ProfilesControllerState extends State<ProfilesController> {
  Utilisateur? utilisateur;
  User? currentUser = FirebaseController().firebase_auth_instance.currentUser;
  String? prenom;
  String? nom;

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return (utilisateur == null)
        ? Center(
            child: Text("Chargement ..."),
          )
        : SingleChildScrollView(
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
                ElevatedButton(
                    child: Text("Sauvegarder"), onPressed: saveChanges),
                TextButton(
                    child: Text("Se déconnecter"),
                    onPressed: () {
                      logOut();
                    })
              ],
            ),
          ));
  }

  Future<void> logOut() async {
    Text titre = Text("Se déconnecter");
    Text contenant = Text("Etes vous sur de vouloir vous deconnecter ?");
    ElevatedButton noBtn = ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("non"));
    ElevatedButton yesBtn = ElevatedButton(
        onPressed: () {
          FirebaseController()
              .seDeconnecter()
              .then((bool) => Navigator.of(context).pop());
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

  saveChanges() {
    Map<String, String?> map = utilisateur!.toMap();
    if (prenom != null && prenom != "") {
      map["prenom"] = prenom!;
    }
    if (nom != null && nom != "") {
      map["nom"] = nom!;
    }
    FirebaseController().AddOrModifyUser(utilisateur!.uid, map);
    _getUserProfile();
  }

  /// Methode permettant d'obtenir l'utilisateur
  _getUserProfile() {
    FirebaseController().getUtilisateur(currentUser!.uid).then((value) {
      setState(() {
        this.utilisateur = value;
      });
    });
  }
}
