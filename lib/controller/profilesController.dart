import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';

class ProfilesController extends StatefulWidget {
  const ProfilesController({Key? key}) : super(key: key);

  @override
  _ProfilesControllerState createState() => _ProfilesControllerState();
}

class _ProfilesControllerState extends State<ProfilesController> {
  User? utilisateur = FirebaseController().firebase_auth_instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profiles uid:${utilisateur!.uid}"),
    );
  }
}
