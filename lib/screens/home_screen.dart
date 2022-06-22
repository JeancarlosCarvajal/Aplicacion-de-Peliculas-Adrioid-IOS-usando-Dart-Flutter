import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  // const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Home Screen'),
        ),
      ),
    );
  }
}