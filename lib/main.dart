import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/authentificationController.dart';
import 'package:flutter_messager_v2/controller/mainAppController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// @dart=2.9
void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Cette ligne est importante pour l'initialisation de firebase
  // j'attends que firebase soit initialisé
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp()); // je lance l'application
}

class MyApp extends StatelessWidget {
  // Ce widget est notre racine de l'application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: gestionAuthentification(),
    );
  }
}

// Gestion de l'authentification
Widget gestionAuthentification() {
  return StreamBuilder<User?>(
      //Notifies about changes to the user's sign-in state (such as sign-in or sign-out).
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        //Si utilisateur authentifié
        if (snapshot.hasData) {
          // Accès à l'application
          return MainAppController();
        } else {
          //Sinon authentification
          return AuthentificationController();
        }
      });
}
