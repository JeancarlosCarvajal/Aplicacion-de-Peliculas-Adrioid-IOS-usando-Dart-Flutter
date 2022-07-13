import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:provider/provider.dart'; // mateapp genera el template inicial 
import 'package:peliculas/providers/movies_provider.dart'; // aqui esta el MoviesProvider()

void main() => runApp(const AppState()); // tenia MyApp() y lo cambie a AppState() para obtener los datos de las APIS antes de crear el contenido


class AppState extends StatelessWidget { // para manejar varios llamados a varias APIS
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // lazy: false se usa para que tan pronto es creado este widget ChangeNotifierProvider se manda a llamar la inicializacion del el mismo
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false )
      ],
      child: const MyApp(), // una forma de hacerlo tambien
      // builder: (context, child) { // tambien se usa asi
      //   // No longer throws
      //   return const MyApp();
      // }
    );
  } 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse, 
          PointerDeviceKind.touch, 
          PointerDeviceKind.stylus, 
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home'   : ( _ ) => const HomeScreen(),
        'details': ( _ ) => const DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo
        )
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

// Set ScrollBehavior for an entire application.
// MaterialApp(
//   scrollBehavior: MyCustomScrollBehavior(),
//   // ...
// );