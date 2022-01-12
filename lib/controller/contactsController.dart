import 'package:flutter/material.dart';

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
