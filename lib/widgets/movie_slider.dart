import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peliculas/models/models.dart';

// esto era StatelessWidget y lo converti en StatefulWidget, para eliminar la paginacion cunado llegue al final 
// o sea poder manejar las variables y modificarlas
class MovieSlider extends StatefulWidget {
 
 
  final List<Movie> movies; // esto es un Array de elementos del tipo Movie
  final String? title;
  // onNextPage es una funcion que se recibe como argumento en el MovieSlider para que pueda 
  // ser modificable en el foturo y poder mandar la funcion que queramos a requerimiento
  final Function onNextPage; 

  const MovieSlider({
    Key? key, 
    required this.movies,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  // Creamos un objeto del tipo ScrollController que me permite en el initState crear un listener
  final ScrollController scrollController = new ScrollController();

  // initState se crea para ejecutar codigo la primera vez cuando el widget es construido
  @override
  void initState() { 
    // TODO: implement initState 
    super.initState();
    scrollController.addListener(() {
      // print(scrollController.position.pixels); // ver cuanto he recorrido del scroll
      // print(scrollController.position.maxScrollExtent); // ver el ancho total de este scroll
      if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent-500)){
        print('Debo recargar el scroll, llamar Provider');
        // se ejecuta la funcion que le envie por parametros arriba
        widget.onNextPage(); // a todoas las variables o objetos del constructor tengo que agregarles widget. al inicio es una regla en statefulwidget
      }

    });
  }

  // dispose cuando el widget va a ser destruido
  @override
  void dispose() {
    // TODO: implement dispose


    super.dispose(); 
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          // si no hay titulo no se debe mostrar este widget
          if(widget.title != null) // NOOO me muestra el padding en caso que no haya titulo
          Padding( // para darle padding al texto
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ), 

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder( // aqui me daba un error porque se sobre pasaba el ancho debido al padding parecido a lo que ocurre en CSS3, y agrege widget Expanded
              controller: scrollController, // para ser leido con el eventlistener
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) => _MoviePoster( movie: widget.movies[index] ),
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