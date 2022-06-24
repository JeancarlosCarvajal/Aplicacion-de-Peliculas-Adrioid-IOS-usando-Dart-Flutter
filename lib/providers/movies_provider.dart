import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart'; 
import '/apis/api_keys.dart';
// import 'dart:convert'; // se usa para manejar los json
class MoviesProvider extends ChangeNotifier { // agrege  extends ChangeNotifier  para que pueda funcionar

  final String _apiKey =  ApiConfig.apiKey; // Api key desde la clase de git ignore en archivo /apis/api_keys.dart
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = []; // carrusel principal

  List<Movie> popularMovies = []; // carrusel de abajo

  int _popularPage = 0;

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



}