import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829


// Creado para ayudar a mejorar la busqueda evitar muchos llamados al servidor cuando se escribe en el buscador
class Debouncer<T> {

  Debouncer({ 
    // cantidad de tiempo que quiero esperar antes de emitir un valor
    required this.duration, 
    // metodo que se dispara cuando tenga un valor
    this.onValue 
  });

  // es una propiedad
  final Duration duration;

  // la funcion es opcional
  void Function(T value)? onValue;

  // el valor del tipo T es decir lo que sea que mando en el inicio de la clase
  T? _value;
  // es opcional viene para generar delay
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    // si recibimos un valor vamos a cencelar el timer
    _timer?.cancel();
    // si el timer cumple la duracion que se especifico se manda a llamar la funcion onValue el cual debe tener el valor del onValue
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}