import 'package:flutter/material.dart';

/// ContactsController est un widget qui permet de créer un contact avec un texte et une image
class ContactsController extends StatefulWidget {
  const ContactsController({Key? key}) : super(key: key);

  @override
  _ContactsControllerState createState() => _ContactsControllerState();
}

class _ContactsControllerState extends State<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Contacts"),
    );
  }
}
