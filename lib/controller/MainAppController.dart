import 'package:flutter/material.dart';

class MainAppController extends StatelessWidget {
  const MainAppController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Messager'),
      ),
      body: Center(
        child: Text('Nous sommes connectés'),
      ),
    );
  }
}
