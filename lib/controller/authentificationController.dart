import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/views/MyPaddingCustomWith.dart';
import 'package:flutter_messager_v2/views/constants.dart';

class AuthentificationController extends StatefulWidget {
  const AuthentificationController({Key? key}) : super(key: key);

  @override
  _AuthentificationControllerState createState() =>
      _AuthentificationControllerState();
}

class _AuthentificationControllerState
    extends State<AuthentificationController> {
  // par défaut, l'utilisateur est connecté (true) ou non (false).
  bool _isUserConnected = true;
  var _adresseEmail;
  var _motDePasse;
  var _nom;
  var _prenom;
  var _imageUrl = "";

  PageController? _pageController;

  @override
  void initState() {
    /// Initialisation de la page de connexion
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    /// Dispose le PageController pour éviter les fuites de mémoire
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              // Controleur de la page
              controller: _pageController,
              children: [viewSignInWidget(0), viewSignInWidget(1)],
            ),
          ),

          TextButton(
            onPressed: () {
              setState(() {
                _isUserConnected =
                    !_isUserConnected; // changement de l'état de l'utilisateur (connecté ou non) lors du clic sur le bouton
              });
            },
            // affichage du texte du bouton en fonction de l'état de l'utilisateur
            child: Text(
                (_isUserConnected) ? "Creation de compte" : "Authentification"),
          ),
          ElevatedButton(
            onPressed: () {
              _gestionnaireDeConnexion();
            },
            child: Text('Se connecter'),
          ), // SizedBox(height: 10,)
        ],
      ),
    );
  }

  /// View de connexion ou de création de compte en fonction de l'index passé en paramètre (0 ou 1)
  Widget viewSignInWidget(int index) {
    /// Dans un SingleChildScrollView pour palier au problème de "A RenderFlex overflowed"
    return SingleChildScrollView(
      child: Column(
        children: [
          MyPaddingCustomView(
            top: 50,
            bottom: 50,
            left: 20,
            right: 20,
            unWidget: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: cColorWhite,
              elevation: 7,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        // si true, on affiche les champs de connexion, sinon on affiche les champs de création de compte
                        children: listTextFields((index == 0)),
                      ),
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                    )
                  ]
                  //listOfUserTextField((index == 0)),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  /// Retourne une liste de textfield pour la connexion ou la création de compte en fonction de l'index passé en paramètre (0 ou 1)
  List<Widget> listTextFields(bool isUserConnected) {
    // On cree une liste de textfield
    List<Widget> widgets = [];
    // Si utilisateur connecté on affiche que les textfields pour l'adresse email et le mot de passe
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
// Si utilisateur non connecté on affiche les textfields pour le nom, le prenom
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

  /// Gestion de la connexion ou de la création de compte en fonction de la valeur de _isUserConnected (true = connexion, false = création de compte)
  void _gestionnaireDeConnexion() {
    if (_adresseEmail != null) {
      if (_motDePasse != null) {
        if (_isUserConnected) {
          // Connexion de l'utilisateur avec l'adresse email et le mot de passe
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
              // Création de compte avec l'adresse email, le mot de passe, le nom, le prenom
              FirebaseController()
                  .creationDeCompte(
                      _adresseEmail, _motDePasse, _prenom, _nom, _imageUrl)
                  .then((value) => print(value!.uid))
                  .catchError((onError) {
                alerte(onError.toString());
              });
            } else {
              // Erreur : le nom n'est pas renseigné
              alerte("Aucun nom n'à été renseigné");
            }
          } else {
            // Erreur : le prenom n'est pas renseigné
            alerte("Aucun prénom n'à été renseigné");
          }
        }
      } else {
        // Erreur : le mot de passe n'est pas renseigné
        alerte("Aucun mot de passe n'à été renseigné");
      }
    } else {
      // Erreur : l'adresse email n'est pas renseigné
      alerte("Aucune adresse email n'à été renseigné");
    }
  }

  /// Affichage d'une alerte avec le texte passé en paramètre (message d'erreur)
  Future<dynamic> alerte(String message) {
    Text title = Text('Erreur');
    Text msg = Text(message);
    TextButton okButton = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text('ok'));
// Affichage de l'alerte avec le titre, le message et le bouton ok (fermeture de l'alerte)
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // Si iOS on affiche une alerte iOS
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: msg, actions: [])
              : AlertDialog(
                  // Sinon on affiche une alerte Android
                  title: title,
                  content: msg,
                  actions: [okButton],
                );
        });
  }
}
