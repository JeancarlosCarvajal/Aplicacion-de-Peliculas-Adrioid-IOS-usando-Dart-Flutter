import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie

    // settings.arguments es una pelicula ahora
    // por lo tanto debo agregar 'as Movie'
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);
 
    return  Scaffold(
      body: CustomScrollView(
        slivers: [ // slivers son widgets que tienen cierto comportamiento programado cuando se hace scroll en el contenido del padre
        // aqui adentro solo acepta widgets que sean familia de los slivers
          _CustomAppBar(movie: movie),


          SliverList( // lo uso de pruebas para poder ver el SliverAppBar
            // Para ello, se utiliza un delegado para crear elementos a medida que
            // se desplazan por la pantalla. 
            delegate: SliverChildListDelegate([
              // La función builder devuelve un ListTile con un título que
              // muestra el índice del elemento actual

              _PostetAndTitle(movie: movie),
              _Overview(movie: movie),
              // _Overview(movie: movie),
              // _Overview(movie: movie),
              // _Overview(movie: movie),
              // _Overview(movie: movie),
              // _Overview(movie: movie),
              // _Overview(movie: movie),
              
              CastingCards(movieId: movie.id)

            ]),
          ),

            // SliverList( // lo uso de pruebas para poder ver el SliverAppBar
            //   // Para ello, se utiliza un delegado para crear elementos a medida que
            //   // se desplazan por la pantalla. 
            //   delegate: SliverChildBuilderDelegate(
            //     // La función builder devuelve un ListTile con un título que
            //     // muestra el índice del elemento actual
            //     (context, index) => ListTile(title: Text('Item #$index')),
            //     // Construye 1000 ListTiles
            //     childCount: 1000,
            //   ),
            // ),


          
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar( // crea un appBar pero con efecto de scroll se esconde al subir a medida, se ve solo si hay muchos elementos
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false, //
      pinned: true, // no se esconda del todo
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0), // evita padding indeseado algo asi como que pasa en CSS3
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12, // negro transparente
          child: Text(
              movie.title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),

        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}


class _PostetAndTitle extends StatelessWidget {

  final Movie movie;
  const _PostetAndTitle({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // para reducir codigo se crea esto en un final para ser usado debajo
    // esto me dice que los estilos se usaran de un tema que vamos a crear
    final TextTheme textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero( // esto es para hacer efecto de zoom cuando voy de una pantalla a otra, si en la otra pantalla esta el mismo elemento entonces se hace zoom deben tener el mismo id
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPostering),
                height: 150, 
              ),
            ),
          ),

          const SizedBox(width: 20,), // crea caja separadora entre el proximo elemento del row

          ConstrainedBox( // cree el constraineBox porque algunos titulos se salian por los lados
            constraints: BoxConstraints(maxWidth: size.width-190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5),
                    Text(movie.voteAverage.toString(), style: textTheme.caption)
                  ],
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}



class _Overview extends StatelessWidget {

  final Movie movie;
  const _Overview({
    Key? key,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}