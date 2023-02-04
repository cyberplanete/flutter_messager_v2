import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/contactsController.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/controller/messagesController.dart';
import 'package:flutter_messager_v2/controller/profilesController.dart';

class MainAppController extends StatefulWidget {
  MainAppState createState() => new MainAppState();
}

class MainAppState extends State<MainAppController> {
  late String id;

  get tabBuilder => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseController().myId().then((value) {
      setState(() {
        id = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPlatform = Theme.of(context).platform;

    /// Création de la barre de navigation en bas de l'écran (bottomNavigationBar)
    if (currentPlatform == TargetPlatform.iOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.blue,
          activeColor: Colors.black,
          inactiveColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.message)),
            BottomNavigationBarItem(icon: Icon(Icons.supervisor_account)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle))
          ],
        ),
        tabBuilder: (BuildContext buildContext, int index) {
          Widget controllerSelected = listOfControllers()[index];
          return Scaffold(
              appBar: AppBar(title: Text('Flutter Messager')),
              body: controllerSelected);
        },
      );
    } else {
      // Android
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Messager'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.message)),
                Tab(icon: Icon(Icons.supervisor_account)),
                Tab(
                  icon: Icon(Icons.account_circle),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: listOfControllers(),
          ),
        ),
      );
    }
  }

  /// Liste des controllers à afficher dans le body de la page principale (MainAppController)
  List<Widget> listOfControllers() {
    return [
      MessagesController(),
      ContactsController(
        id: id,
      ),
      ProfilesController(id: id)
    ];
  }
}
