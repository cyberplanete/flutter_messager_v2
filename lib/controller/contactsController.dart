import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/model/Utilisateur.dart';

/// ContactsController est un widget qui permet de créer un contact avec un texte et une image
class ContactsController extends StatefulWidget {
  const ContactsController({Key? key}) : super(key: key);

  @override
  _ContactsControllerState createState() => _ContactsControllerState();
}

class _ContactsControllerState extends State<ContactsController> {
  var list = FirebaseDatabase.instance.ref().child("utilisateurs");

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref().child("utilisateurs"),
        itemBuilder: (BuildContext context, DataSnapshot dataSnapshot,
            Animation<double> animation, int index) {
          Utilisateur newUtilisateur = Utilisateur.fromSnapshot(dataSnapshot);
          if (newUtilisateur.uid !=
              FirebaseController().auth_instance.currentUser?.uid) {
            return ListTile(
              title: Text(newUtilisateur.prenom[0].toUpperCase() +
                  newUtilisateur.prenom.substring(1) +
                  " " +
                  newUtilisateur.nom[0].toUpperCase() +
                  newUtilisateur.nom.substring(1)),
            );
          } else {
            return Container();
          }
        });
  }
}
