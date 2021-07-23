import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/FireBaseController.dart';

class AuthentificationController extends StatefulWidget {
  const AuthentificationController({Key? key}) : super(key: key);

  @override
  _AuthentificationControllerState createState() =>
      _AuthentificationControllerState();
}

class _AuthentificationControllerState
    extends State<AuthentificationController> {
  // Si True, création de compte, false identification
  bool _isUserConnected = true;
  var _adresseEmail;
  var _motDePasse;
  var _nom;
  var _prenom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
      ),
      body: SingleChildScrollView(
        ///Permet de cacher le clavier onTap en dehors du textField
        child: InkWell(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width - 40,
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  elevation: 7.5,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: listTextFields(),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isUserConnected = !_isUserConnected;
                  });
                },
                child: Text((_isUserConnected)
                    ? "Authentification"
                    : "Creation de compte"),
              ),
              ElevatedButton(
                onPressed: () {
                  _gestionDeConnexion();
                },
                child: Text('Connecté'),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listTextFields() {
    List<Widget> widgets = [];
    widgets.add(TextField(
      decoration: InputDecoration(hintText: 'Adresse Email'),
      onChanged: (text) {
        setState(() {
          _adresseEmail = text;
        });
      },
    ));

    widgets.add(
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: 'Mot de passe'),
        onChanged: (text) {
          setState(() {
            _motDePasse = text;
          });
        },
      ),
    );

    if (!_isUserConnected) {
      widgets.add(TextField(
        decoration: InputDecoration(hintText: 'Prénom'),
        onChanged: (texte) {
          _prenom = texte;
        },
      ));
      widgets.add(TextField(
        decoration: InputDecoration(hintText: 'Nom'),
        onChanged: (texte) {
          _nom = texte;
        },
      ));
    }

    return widgets;
  }

  void _gestionDeConnexion() {
    if (_adresseEmail != null) {
      if (_motDePasse != null) {
        if (_isUserConnected) {
          //Connexion
          FirebaseController()
              .seConnecter(_adresseEmail, _motDePasse)
              .then((value) => print(value!.uid))
              .catchError((onError) {
            alerte(onError.toString());
          });
        } else {
          //Création de compte
          if (_prenom != null) {
            if (_nom != null) {
              //Méthode pour créer un utilisateur
              FirebaseController()
                  .creationDeCompte(_adresseEmail, _motDePasse, _prenom, _nom)
                  .then((value) => print(value!.uid))
                  .catchError((onError) {
                alerte(onError.toString());
              });
            } else {
              //Alerte pas de nom
              alerte("Aucun nom n'à été renseigné");
            }
          } else {
            //Alerte pas de prénom
            alerte("Aucun prénom n'à été renseigné");
          }
        }
      } else {
        //Alerte pas de mdp
        alerte("Aucun mot de passe n'à été renseigné");
      }
    } else {
      //Alerte pas d'adresse email
      alerte("Aucune adresse email n'à été renseigné");
    }
  }

  Future<dynamic> alerte(String message) {
    Text title = Text('Erreur');
    Text msg = Text(message);
    TextButton okButton = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text('ok'));
// Une alerte est affiché selon l'OS utilisé.
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: msg, actions: [])
              : AlertDialog(
                  title: title,
                  content: msg,
                  actions: [okButton],
                );
        });
  }
}
