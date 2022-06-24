import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/models/models.dart';

class MovieSlider extends StatelessWidget {
 
 
  final List<Movie> movies; // esto es un Array de elementos del tipo Movie
  final String? title;

  const MovieSlider({
    Key? key, 
    required this.movies,
    this.title,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          // TODO si no hay titulo no se debe mostrar este widget
          if(title != null) // NOOO me muestra el padding en caso que no haya titulo
          Padding( // para darle padding al texto
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ), 

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder( // aqui me daba un error porque se sobre pasaba el ancho debido al padding parecido a lo que ocurre en CSS3, y agrege widget Expanded
            scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _ , int index) => _MoviePoster( movie: movies[index] ),
            ),
          ),



        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  
  final Movie movie; // esto es la Movie es como una constante del tipo Movie

  const _MoviePoster({
    Key? key,  
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),//pa que me separe lo items uno del otro
      child: Column(
        children:  [


          GestureDetector( // Para poder disparar click enviar a la otra pagina
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'Movie Instance'), // envia a otra pagina de details
            child: ClipRRect( // permite redondear los bordes
            borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPostering), // aqui va la imagen de la API
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 5,),

          Text(
            movie.title, // Aqui va la respuesta de la API
            maxLines: 2, // para que me haga dos lineas luego los tres puntitios con el overflow de abajo
            overflow: TextOverflow.ellipsis, // evita error de barras amarillas por overflow agregando tres puntitos al final parecida a la funcion que hice en PHP
            textAlign: TextAlign.center,
          )


        ],
      ),
    );
  }
}