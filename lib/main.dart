import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/authentificationController.dart';
import 'package:flutter_messager_v2/controller/mainAppController.dart';

// @dart=2.9
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: handleAuth(),
    );
  }
}

/// Gestion de l'authentification
Widget handleAuth() {
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
