import 'package:flutter/material.dart';
import 'package:animations_gallery/pages/menu.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MenuPage(),
      ),
    );
  }
}
