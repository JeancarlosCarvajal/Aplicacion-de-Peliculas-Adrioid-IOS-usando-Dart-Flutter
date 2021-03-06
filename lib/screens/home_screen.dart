import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart'; 

class HomeScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // Ve al arbol de widgets (context) traeme la instancia de MoviesProvider y metelo en la variable final
    // esto sirve es para que cuando llegue la informacion desde la API se redibuje la pantalla y me mueste los datos 
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // print(moviesProvider.onDisplayMovies); // esto sirve es para que cuando llegue la informacion desde la API se redibuje la pantalla y me mueste los datos

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Peliculas en Cines')),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_off_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), // showSearch requiere ciertas condiciones
          )
        ],
      ),
      body: SingleChildScrollView(// evita error si no entra en la pnatalla le hace scroll
        child: Column(
          children: [
            
            //Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
      
            //Listado horizontal de peliculas
            // Slider de peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populars',
              onNextPage: () => moviesProvider.getPopularMovies() // debe ser opcional
            ),
            // MovieSlider(),
            // MovieSlider(),
            // MovieSlider(),
            // MovieSlider(),
            // MovieSlider(),
      
      
          ],
        ),
      )
    );
  }
}