import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

class ProfilesController extends StatefulWidget {
  const ProfilesController({Key? key}) : super(key: key);

  @override
  _ProfilesControllerState createState() => _ProfilesControllerState();
}

class _ProfilesControllerState extends State<ProfilesController> {
  Utilisateur? utilisateur;
  User? currentUser = FirebaseController().firebase_auth_instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseController().getUtilisateur(currentUser!.uid).then((value) {
      setState(() {
        this.utilisateur = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (utilisateur == null)
        ? Center(
            child: Text("Profiles uid:${currentUser!.uid}"),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("${utilisateur?.prenom} ${utilisateur?.nom}"),
            ),
            body: Center(
              child: Text("${utilisateur?.uid}"),
            ),
          );
  }
}
