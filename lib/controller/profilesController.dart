import 'package:flutter/material.dart';

class ProfilesController extends StatefulWidget {
  const ProfilesController({Key? key}) : super(key: key);

  @override
  _ProfilesControllerState createState() => _ProfilesControllerState();
}

class _ProfilesControllerState extends State<ProfilesController> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profiles"),
    );
  }
}
