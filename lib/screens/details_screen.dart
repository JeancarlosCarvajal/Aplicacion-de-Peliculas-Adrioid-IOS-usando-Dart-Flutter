import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie

    // settings.arguments es un objeto se pasa a string
    // esta validacion es para cuando no recibe valores entonces nos devuelva No-movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'No-movie';



    return Scaffold(
      body: CustomScrollView(
        slivers: [ // slivers son widgets que tienen cierto comportamiento programado cuando se hace scroll en el contenido del padre
          _CustomAppBar(),
          SliverList( // lo uso de pruebas para poder ver el SliverAppBar
            // Para ello, se utiliza un delegado para crear elementos a medida que
            // se desplazan por la pantalla. 
            delegate: SliverChildBuilderDelegate(
              // La función builder devuelve un ListTile con un título que
              // muestra el índice del elemento actual
              (context, index) => ListTile(title: Text('Item #$index')),
              // Construye 1000 ListTiles
              childCount: 1000,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar( // crea un appBar pero con efecto de scroll se esconde al subir a medida, se ve solo si hay muchos elementos
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false, //
      pinned: true, // no se esconda del todo
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0), // evita padding indeseado algo asi como que pasa en CSS3
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12, // negro transparente
          child: Text(
              'movie.stile',
              style: TextStyle(fontSize: 16)
            ),

        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}