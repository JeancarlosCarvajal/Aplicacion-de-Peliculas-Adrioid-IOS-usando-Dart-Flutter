import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieSlider extends StatelessWidget {
   
  const MovieSlider({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          const Padding( // para darle padding al texto
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          const SizedBox(height: 5,),

          Expanded(
            child: ListView.builder( // aqui me daba un error porque se sobre pasaba el ancho debido al padding parecido a lo que ocurre en CSS3, y agrege widget Expanded
            scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: ( _ , int index) => const _MoviePoster(),
            ),
          ),

        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({Key? key,}) : super(key: key);

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
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage('https://via.placeholder.com/300x400'),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 5,),

          const Text(
            'StarWars: El retorno del Jedi procedente de Monte Cristo',
            maxLines: 2, // para que me haga dos lineas luego los tres puntitios con el overflow de abajo
            overflow: TextOverflow.ellipsis, // evita error de barras amarillas por overflow agregando tres puntitos al final parecida a la funcion que hice en PHP
            textAlign: TextAlign.center,
          )


        ],
      ),
    );
  }
}