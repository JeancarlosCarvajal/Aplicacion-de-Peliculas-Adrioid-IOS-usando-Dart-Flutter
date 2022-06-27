import 'package:flutter/material.dart'; 
import 'package:card_swiper/card_swiper.dart'; // paquete descargado
import 'package:peliculas/models/models.dart'; // creado por nosotros 

class CardSwiper extends StatelessWidget {
   
  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // para obtener datos de la pantalla

    // en el primer renderizado no da tiempo que cargue los datos de la API por lo tanto se debe colocar este condicional para que aparezca el cargado
    // Una vez el array se llene entonces no entrara en este condicional y se cargara el return que tiene toda la informacion
    if(movies.isEmpty){ 
      return SizedBox(
        width: double.infinity,
        height: size.height*0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height*0.5, // tomar el 60% de la pantalla
      // color: Colors.red,// para pruebas 
      child: Swiper(
        itemCount: movies.length, // cantidad de tarjetas que quiero manejar, se crea los elementos en el carrusel
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.6,
        itemHeight: size.height*0.4,
        itemBuilder: ( _ , int index){

          final movie = movies[index];
          // print(movie.fullPostering);

          // creado para darle id diferente al mismo elemento dependiendo si estan junto en la misma panatalla principal y pueda funcionar el Hero()
          movie.heroId = 'swiper-${movie.id}';

          return GestureDetector( // para ir a la otra pagina haciendo click en imagen del carrusel
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero( //idi unico sino no funciona
              tag: movie.heroId!, // me daba error y le agrege !
              child: ClipRRect( // permite redondear los bordes de las imagenes en el carrusel
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPostering),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }, // construye de manera dinamica
      ),

    ); 
  }
}