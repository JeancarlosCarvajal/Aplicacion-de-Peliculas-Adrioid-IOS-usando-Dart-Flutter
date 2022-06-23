import 'package:flutter/material.dart';
import 'package:peliculas/screens/screens.dart'; // mateapp genera el template inicial 

void main() => runApp(MyApp());


class AppState extends StatelessWidget { // para manejar varios llamados a varias APIS
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home'   : ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}