import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/seach_movie_response.dart'; 
import '/apis/api_keys.dart';
// import 'dart:convert'; // se usa para manejar los json
class MoviesProvider extends ChangeNotifier { // agrege  extends ChangeNotifier  para que pueda funcionar

  final String _apiKey =  ApiConfig.apiKey; // Api key desde la clase de git ignore en archivo /apis/api_keys.dart
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = []; // carrusel pagina principal arriba, cuando es List se iguala a []

  List<Movie> popularMovies = []; // carrusel pagina principal de abajo, cuando es List se iguala a []

  // Uso como llave el Id para que cuando sea buscado se encuentre segun el Id algo parecido a los que hice con el hash the NFT para evitar replicas exactas
  Map<int, List<Cast>> moviestCast = {}; // para los del casting en detalles de la pelicula en la parte de abajo, cuando es apa se iguala a {}

  int _popularPage = 0; // pagina actual

  // se creo para evitar muchos llamados http a la API
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500), 
  );
  final StreamController<List<Movie>> _suggestionStringController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStringController.stream;


  //INICIO Movies del carrosel principal
  MoviesProvider(){
    // print('Movies Provider Initialized');

    getOnDisplayMovies(); // "this." es opcional si no se coloca queda sobre entendido
    getPopularMovies(); // "this." es opcional si no se coloca queda sobre entendido
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async { // [int page = 1] para darle valor por default
  // optimizando codigo
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'languagepage': _language,
      'page': '$page'
    });
    final responce = await http.get(url);
    return responce.body;
  }

  getOnDisplayMovies() async { // vas a ser las pelicuas que se mostraran
    // print('getOnDisplayMovies');
    // https://developers.google.com/books/docs/overview
    // var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
    //   'api_key': _apiKey,
    //   'languagepage': _language,
    //   'page': '1'
    // });

    // Await the http get response, then decode the json-formatted response.
    // final response = await http.get(url);
    // if(response.statusCode != 200) return print('error');
    // Map<String, dynamic> especifico el tipo de datos que va recibir
    // final Map<String, dynamic> decodeData = json.decode(response.body); // json.decode proviene de paquete import dart:convert
    final jsonData = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    // print(decodeData);
    // print(nowPlayingResponse.results[1].title);

    onDisplayMovies = nowPlayingResponse.results; // son dos array por lo tanto son compatibles y se igualan

    notifyListeners(); // es importante porque si hay cambio en la data redibuja toda la pantalla automaticamente 
  }
  // FIN Movies del carrusel de abajo

  getPopularMovies() async {
    // print('getPopularMovies');
    // var url = Uri.https(_baseUrl, '/3/movie/popular', {
    //   'api_key': _apiKey,
    //   'languagepage': _language,
    //   'page': '1'
    // });

    // Await the http get response, then decode the json-formatted response.
    // final response = await http.get(url);
    // if(response.statusCode != 200) return print('error');
    // Map<String, dynamic> especifico el tipo de datos que va recibir
    // final Map<String, dynamic> decodeData = json.decode(response.body); // json.decode proviene de paquete import dart:convert
    _popularPage++; // aumenta la pagina en uno para que se infinito
    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    // print(decodeData);
    // print(popularResponse.results[1].title);

    //[ ...popularMovies, ...popularResponse.results ]
    // es una forma de concatenar dos arrays para ir incrementandolo y lo que tenia cargado se me vaya quedando 
    popularMovies = [ ...popularMovies, ...popularResponse.results ]; // son dos array por lo tanto son compatibles y se igualan

    // print(popularMovies[0]);

    notifyListeners(); // es importante porque si hay cambio en la data redibuja toda la pantalla automaticamente 
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if(moviestCast.containsKey(movieId)) return moviestCast[movieId]!; // esta cacheado en este mapa para evitar peticion http sin necesidad
    //  revisar el mapa
    // print('Pidiendo info al servidor de los actores');
    final jsonData = await _getJsonData('/3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviestCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast; 
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'languagepage': _language,
      // 'page': '$page',  // opcional
      'query': query

    });
    
    final responce = await http.get(url);
    // asi deberia ser origilamente pero al agregarle fromJson, se encarga automaticamente de cargarle los datos desde el Json
    // final searchResponse = SearchResponse(page: page, results: results, totalPages: totalPages, totalResults: totalResults)
    final searchResponse = SearchResponse.fromJson(responce.body);
    return searchResponse.results;
  }

  // este metodo mete el valor de query al string cuando el debouncer emita el valor o que es lo mismo cuando la persona deja de escribir
  void getSuggestionsByQuery( String searchTerm ) { 
    debouncer.value = ''; // limpiamos el valor
    // una vez se tenga valor se activa el debouncer
    debouncer.onValue = ( value ) async { // aqui el this es opcional
      // print('Tenemos un valor a buscar: $value');
      final results = await this.searchMovie(value); // el value viene siendo el query
      this._suggestionStringController.add(results); // al tener los reusltados se agrega el evento en el suggestionStringController
    };

    // creamos un timer 
    final timer = Timer.periodic(const Duration(milliseconds: 300), ( _ ) {
      debouncer.value = searchTerm;
    });

    // cancelar el timar si se vuelve a recibir el valor
    Future.delayed(const Duration(milliseconds: 301)).then(( _ ) => timer.cancel());

  }

}