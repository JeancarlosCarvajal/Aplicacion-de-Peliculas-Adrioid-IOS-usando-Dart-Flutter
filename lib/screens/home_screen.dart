import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart'; 

class HomeScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  // const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Peliculas en Cines')),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.search_off_outlined)
          )
        ],
      ),
      body: Column(
        children: const [
          
          CardSwiper(),

          //Listado horizontal de peliculas

        ],
      )
    );
  }
}