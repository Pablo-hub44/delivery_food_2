// estado global
import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:flutter/material.dart';

class MyCartController extends ChangeNotifier {
  Map<int, Platillo> _cart = {}; //donde se va a guardar los favs agregados al carrito
  Map<int, Platillo> get cart => _cart;

//la propiedades pal check out
//                 .map pa mapear | .reduce itera en cada valor de la lista, para que se sume nuestra lista
  double get subtotal => double.parse(
      cart.values.map((e) => e.price * e.counter).toList().reduce((value, element) => value + element).toStringAsFixed(2));
  double get iva => double.parse((subtotal * 0.10 + subtotal).toStringAsFixed(2)); //aqui podemos sumarle lo q queramos jeje
  double get envio => 2.0;
  double get total => double.parse((subtotal + iva + envio).toStringAsFixed(2)); //toStringAsFixed para ponerle solo 2 decimales

  // propiedad para saber si tiene item en el carrito
  bool get hasItems => _cart.isNotEmpty;

  //metodo agregar al carrito
  void addToCart(Platillo dish, {bool update = true}) {
    Map<int, Platillo> copyMap = Map<int, Platillo>.from(_cart); //una copia del carrito
    copyMap[dish.id] = dish; //si el producto ya existia, simplemente se reemplaza, si no estaba lo agrega
    _cart = copyMap; //ahora _cart sera igual a la nueva copia
    if (update) {
      //si update es verdadero entonces .
      notifyListeners(); //notificamos a las partes involucradas :D
    }
  }

  // metodo para borrar algo de nuestro carrito
  void deleteFromCart(Platillo dish) {
    Map<int, Platillo> copyMap = Map<int, Platillo>.from(_cart);

    if (copyMap.containsKey(dish.id)) {
      //si el platillo esta en el carrito(por su id) lo borrara
      copyMap.remove(dish.id);
      _cart = copyMap; //la copia se la ponemos a _cart
      notifyListeners(); //notificamos a las partes involucradas :D
    }
  }

  //metodo para q cambie el boton cuando un pplatillo ya esta agregado al cart | lo de agregar al carrito o modificar carrito
  bool isIncart(Platillo dish) {
    return _cart.containsKey(dish.id); //retornar true si en el cart contiene el id del platillo
  }

  //metodo conseguir el contador de dish de devuelve un entero
  int getDishCounter(Platillo dish) {
    if (isIncart(dish)) {
      return _cart[dish.id]!.counter; //si esta en el carrito, q nos retorne su contador, !no puede ser nulo
    }
    return 0; //sino un 0
  }

  //metodo para que aparezca el boton al carrito y es que hay algo dentro

}
