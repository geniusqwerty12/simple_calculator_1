import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: new ThemeData.dark(),
      home: new HomePage(),
    );
  }
}