import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
   
  const CastingCards({
    Key? key,
    required this.movieId
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: ( _  , AsyncSnapshot<List<Cast>> snapshot){ // retorna un tipo <List<Cast>>
      
        if(!snapshot.hasData){
          return Container(
            constraints: const BoxConstraints(maxWidth: 150),
            height: 180,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;
        // print(cast.contains(''));
        return Stack(
          children:
          [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                'Actors',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 280,
              // color: Colors.red, // usado de referencia para ver los amrgins y paddings
              child: ListView.builder(
                itemCount: cast.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ( _ , int index) => _CastCard(actor: cast[index]),
              ),
            ),
          ]
        );
      },
    );
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;
  
  const _CastCard({
    Key? key,
    required this.actor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 75, bottom: 0),
      width: 110,
      height: 100,
      // color: Colors.green, // usado de referencia para ver los margenes y paddings
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(actor.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5 ),
            Text(
              actor.name,
              // 'Hola Mundo Hola MUnndo Hola Munndo Hola Mundo Hola Mundo Hola Mundo Hola Mundo Hola Mundo Hola Mundo',
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // ellipsis crea los puntitos
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}