import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  // const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Details Screen'),
        ),
      ),
    );
  }
}