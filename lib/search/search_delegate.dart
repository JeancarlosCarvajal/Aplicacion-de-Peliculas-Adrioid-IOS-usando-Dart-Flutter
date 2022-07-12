import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart'; 

class MovieSearchDelegate extends SearchDelegate {

  // cambiar el idioma reescribiendo el getter searchFieldLabel
  @override
  String get searchFieldLabel => 'Buscar a';
 
  
  // Aqui debo agregar formato al boton de limpiar 
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query='', // query es la info que se escribe en el buscador, se iguala a vacio para limpiar 
      )
    ];
  }
  
  // regresar en la pantalla anterior
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null); // el close es complemento del SearchDelegate, al enviarle null me devuelde a la anterior
      },
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    // return const Text('test');
    // return Text('buildSuggestions: $query') ;
    // si viene vacia la busqueda 
    // print('moviesProvider 1');
    // $query proviene del searchresearch
     // aparece lo que se esta escribiendo en la parte de abajo
    // return Text('buildSuggestions: $query') ;
    if((query.trim()).isEmpty){
      // print('Query vacio');
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
      );
    }
    // print('http request');
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);


    // esto se creo para manejar las veces que se hace las peticiones http evitar muchos llamados a la API
    //  se manda a llamar cada vez que la persona toca una tecla o teclas direciconales
    moviesProvider.getSuggestionsByQuery(query);

    // el StreamBuilder solo se va a redibujar cuando  moviesProvider.suggestionStream emite un valor mediante un evento add()
    return StreamBuilder( // era FutureBuilder, lo cambie para poder manejar el evento del input evitar que pida demasiados llamados http a la API
      stream: moviesProvider.suggestionStream, 
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot){ // <List<Movie>> me importo 'package:peliculas/models/models.dart';
        if(!snapshot.hasData) return _emptyContainer(); 

        final movies = snapshot.data;

        return ListView.builder(
          itemCount: movies!.length,
          itemBuilder: ( _, int index) => _MovieItem(movie: movies[index])
        );

      },
    );
  }

  // para ser usado como respuesta vacia de la busqueda
  Widget _emptyContainer() {
    return const Center(
      child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
    );
  }
  
  // buildSuggestions se va ir disparando cada vez que una persona toca una tecla
  @override
  Widget buildSuggestions(BuildContext context) { 
    // return Text('buildSuggestions: $query') ;
    // si viene vacia la busqueda 
    // print('moviesProvider 1');
    // $query proviene del searchresearch
     // aparece lo que se esta escribiendo en la parte de abajo
    // return Text('buildSuggestions: $query') ;
    if((query.trim()).isEmpty){
      // print('Query vacio');
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
      );
    }
    // print('http request');
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);


    // esto se creo para manejar las veces que se hace las peticiones http evitar muchos llamados a la API
    //  se manda a llamar cada vez que la persona toca una tecla o teclas direciconales
    moviesProvider.getSuggestionsByQuery(query);

    // el StreamBuilder solo se va a redibujar cuando  moviesProvider.suggestionStream emite un valor mediante un evento add()
    return StreamBuilder( // era FutureBuilder, lo cambie para poder manejar el evento del input evitar que pida demasiados llamados http a la API
      stream: moviesProvider.suggestionStream, 
      builder: ( _ , AsyncSnapshot<List<Movie>> snapshot){ // <List<Movie>> me importo 'package:peliculas/models/models.dart';
        if(!snapshot.hasData) return _emptyContainer(); 

        final movies = snapshot.data;

        return ListView.builder(
          itemCount: movies!.length,
          itemBuilder: ( _, int index) => _MovieItem(movie: movies[index])
        );

      },
    );
  }
}
 
class _MovieItem extends StatelessWidget {

  final Movie movie; 
   
  const _MovieItem({
    Key? key, 
    required this.movie
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // creado para darle id diferente al mismo elemento dependiendo si estan junto en la misma panatalla principal y pueda funcionar el Hero()
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPostering),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: movie);
        // print(movie.title);
      },
    );
  }
}