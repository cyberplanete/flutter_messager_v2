import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messager_v2/controller/contactsController.dart';
import 'package:flutter_messager_v2/controller/fireBaseController.dart';
import 'package:flutter_messager_v2/controller/messagesController.dart';
import 'package:flutter_messager_v2/controller/profilesController.dart';

class MainAppController extends StatelessWidget {
  User? utilisateurFirebase =
      FirebaseController().firebase_auth_instance.currentUser;

  get tabBuilder => null;

  @override
  Widget build(BuildContext context) {
    final currentPlatform = Theme.of(context).platform;

    /// Version IOS
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

  List<Widget> listOfControllers() {
    return [MessagesController(), ContactsController(), ProfilesController()];
  }
}
