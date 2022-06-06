import 'dart:async';

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  //inicialiamos/inyectamos nuestras dependencias al principio
  setUpAll(() async {
    TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });
  group('dish detail controller', () {
    late DishController controller;
    //inicialiamos nuestras dependencias al principio de este grupo
    setUp(() {
      // creamo un platillo
      final platillo = Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );
      final arguments = DishpageArguments(dish: platillo, tag: "123");
      controller = DishController(arguments, false);
    });

// vamos a testear onCounterChanged, q el contador de + y - funcione
    test('onCounterChanged', () {
      // comprobar q el contador sea iguala 0
      expect(controller.dish.counter, 0);
      controller.onCounterChanged(5);
      expect(controller.dish.counter, 5); //0 daria error ya que en oncounter es 5
    });

// testar el boton de favotitos
    test('toggleFavorite', () async {
      expect(controller.isFavorite, false); //true daria error ya q en un inicio es false
      // completer es A way to produce Future objects and to complete them later with a value or error.
      Completer<bool> completer = Completer();
      // para probar| escuchar el evento notifylisteners,
      controller.addListener(() {
        completer.complete(controller.isFavorite); //para q veamos si si notifica a las partes involucradas
      });

      controller.toggleFavorite();
      expect(controller.isFavorite, true); //false daria error ya q al llamar a togglefav se vuleve true
      expect(await completer.future, true);
    });

    // testear dispose
    test('dispose', () async {
      // completer es A way to produce Future objects and to complete them later with a value or error.
      Completer<bool> completer = Completer();
      controller.onDispose = () {
        completer.complete(true); //complete probamos q si se llamo a esta fuction
      };
      controller.dispose();
      expect(await completer.future, true); //se espera q sea true
    });
  });
}
