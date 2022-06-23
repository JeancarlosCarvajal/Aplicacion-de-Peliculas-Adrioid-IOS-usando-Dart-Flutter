import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import '/apis/api_keys.dart';

class MoviesProvider extends ChangeNotifier { // agrege  extends ChangeNotifier  para que pueda funcionar

  final String _apiKey =  ApiConfig.apiKey; // Api key desde la clase de git ignore
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';



  MoviesProvider(){
    // print('Movies Provider Initialized');

    getOnDisplayMovies(); // "this." es opcional si no se coloca queda sobre entendido
  }

  getOnDisplayMovies() async { // vas a ser las pelicuas que se mostraran
    // print('getOnDisplayMovies');
    // https://developers.google.com/books/docs/overview
    var url = Uri.https(_baseUrl, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'languagepage': _language,
      'page': '1'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);

  }
}