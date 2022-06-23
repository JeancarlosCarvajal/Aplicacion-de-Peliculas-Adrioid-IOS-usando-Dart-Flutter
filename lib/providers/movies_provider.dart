




class MoviesProvider {
  MoviesProvider(){
    print('Movies Provider Initialized');

    getOnDisplayMovies(); // "this." es opcional si no se coloca queda sobre entendido
  }

  getOnDisplayMovies() async { // vas a ser las pelicuas que se mostraran
    print('getOnDisplayMovies');

  }
}