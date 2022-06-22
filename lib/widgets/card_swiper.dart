import 'package:flutter/material.dart'; 
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
   
  const CardSwiper({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size; // para obtener datos de la pantalla

    return Container(
      width: double.infinity,
      height: size.height*0.5, // tomar el 60% de la pantalla
      // color: Colors.red,// para pruebas 
      child: Swiper(
        itemCount: 10, // cantidad de tarjetas qeu quiero manejar
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.6,
        itemHeight: size.height*0.4,
        itemBuilder: ( _ , int index){
          return GestureDetector( // para ir a la otra pagina haciendo click en imagen del carrusel
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect( // permite redondear los bordes de las imagenes en el carrusel
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage('https://via.placeholder.com/300x400'),
                fit: BoxFit.cover,
              ),
            ),
          );
        }, // construye de manera dinamica
      ),

    ); 
  }
}