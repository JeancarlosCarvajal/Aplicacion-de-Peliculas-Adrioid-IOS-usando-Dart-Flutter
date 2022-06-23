import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
   // Key identifica el widget en el arbol de widgets
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    // TODO: Cambiar luego por una instancia de movie

    // settings.arguments es un objeto se pasa a string
    // esta validacion es para cuando no recibe valores entonces nos devuelva No-movie
    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'No-movie';
 
    return  Scaffold(
      body: CustomScrollView(
        slivers: [ // slivers son widgets que tienen cierto comportamiento programado cuando se hace scroll en el contenido del padre
        // aqui adentro solo acepta widgets que sean familia de los slivers
          _CustomAppBar(),


            SliverList( // lo uso de pruebas para poder ver el SliverAppBar
              // Para ello, se utiliza un delegado para crear elementos a medida que
              // se desplazan por la pantalla. 
              delegate: SliverChildListDelegate([
                // La función builder devuelve un ListTile con un título que
                // muestra el índice del elemento actual

                _PostetAndTitle(),

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
  const _CustomAppBar({Key? key}) : super(key: key);

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
          color: Colors.black12, // negro transparente
          child: const Text(
              'movie.stile',
              style: TextStyle(fontSize: 16)
            ),

        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}


class _PostetAndTitle extends StatelessWidget {
  const _PostetAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // para reducir codigo se crea esto en un final para ser usado debajo
    // esto me dice que los estilos se usaran de un tema que vamos a crear
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          const SizedBox(width: 20,), // crea caja separadora entre el proximo elemento del row
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //style: Theme.of(context).textTheme.headline5 .. se hace para que adquiera los stilos del tema que personalicemos
              Text('movie.data', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
              Row(
                children: [
                  const Icon(Icons.star_border_outlined, size: 15, color: Colors.grey,),
                  const SizedBox(width: 5),
                  Text('movie.voteAverage', style: textTheme.caption)
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}
