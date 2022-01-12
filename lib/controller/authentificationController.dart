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
  // Si True, création de compte, false identification
  bool _isUserConnected = true;
  var _adresseEmail;
  var _motDePasse;
  var _nom;
  var _prenom;
  var _imageUrl = "";

  PageController? _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
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
              //Retourne l'index de la page
              controller: _pageController,
              children: [viewSignIn(0), viewSignIn(1)],
            ),
          ),

          TextButton(
            onPressed: () {
              setState(() {
                _isUserConnected = !_isUserConnected;
              });
            },
            child: Text(
                (_isUserConnected) ? "Authentification" : "Creation de compte"),
          ),
          ElevatedButton(
            onPressed: () {
              //TODO
              _gestionDeConnexion();
            },
            child: Text('Connecté'),
          ), // SizedBox(height: 10,)
        ],
      ),
    );
  }

  List<Widget> listTextFields(bool isUserConnected) {
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
                  .creationDeCompte(
                      _adresseEmail, _motDePasse, _prenom, _nom, _imageUrl)
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

  ///Se positionne dessous les boutons - Affiche les vues contenant des textfields permettant la connexion ou la creation du compte
  ///l'index 0 est pour un utilisateur deja enregistré
  Widget viewSignIn(int index) {
    /// Dans un SingleChildScrollView pour palier au problème de "A RenderFlex overflowed"
    return SingleChildScrollView(
      child: Column(
        children: [
          MyPaddingCustomWith(
            top: 50,
            bottom: 50,

            ///Padding a partir du bord de l'écran
            left: 20,
            right: 20,
            unWidget: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: cColorWhite,
              elevation: 7,

              ///Card invisible si pas de child !!!
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  ///l'index 0 est pour un utilisateur deja enregistré
                  children: [
                    Container(
                      child: Column(
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
}
