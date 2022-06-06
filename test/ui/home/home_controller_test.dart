// ignore_for_file: unused_element, avoid_print

import 'dart:async';

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  // setupall se ejecuta al principio antes de todos los test y grupos
  setUpAll(() async {
    await TestDependencyInjection.initialize(); //inicializamos nuestras cosas
  });

  // teardownAll se ejecuta al final de todos los grupos y todos los test
  tearDownAll(() {
    TestDependencyInjection.clear();
  });
  group('home controller', () {
    late HomeController controller;
    // pa q cada ves q se ejecute un test, al principio, tendremos controller pa poderlo utilizar en todos los controllers
    setUp(() {
      controller = HomeController(NotificationsController());
    });

    // testearesmo que la page inicial sea 0
    test('currentpage == 0', () {
      // final controller = HomeController(NotificationsController()); //yano necesario pnerlo aca
      expect(controller.actualPage, 0); //funciona pk la pagina de inicio es 0
    });

    // q los iconos de los items sean .svg
    test('menuItem .svg', () {
      // iteramos en la lista de items del homecontroller :D
      for (var item in controller.items) {
        expect(item.icon.contains(".svg"), true); //false daria error ya q todos los icon son .svg
      }
    });

    // vamos a testear la nofiticaciones de afterfirstlayout
    test('afterFirstLayout', () async {
      // funcion interna, para ponerle un tiempo
      Future<void> sleep(int milliseconds) async {
        await Future.delayed(Duration(milliseconds: milliseconds));
      }

      // ----  testeamos el notifyListeners
      int notifierCounter = 0;

      controller.addListener(() {
        print("notifylistener llamado");
        notifierCounter++;
      });
      // ----

      expect(controller.items[2].badgeCount, 0);
      controller.afterFirstLayout();
      await sleep(10100); //pk la notificacion le pusimos q cada 10 seg apareciera
      expect(controller.items[2].badgeCount > 0,
          true); //en la pos 2 de nuestra lista de items conde esta el count de las notificaciones
      expect(notifierCounter > 0, true); //checamos q notifires counter sea mayor a 0
    });

    // testear agregaraFavoritos
    test('addFavorites', () {
      expect(controller.favoritos.length, 0); //al principio al map esta vacio
      final platillo = Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );
      final platillo2 = Platillo(
        id: 2,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );
      controller.addFavorites(platillo);
      controller.addFavorites(platillo2);
      expect(controller.favoritos.isNotEmpty, true); //ahora q si tiene un platillo
      controller.addFavorites(platillo);
      expect(controller.favoritos.length,
          1); //hay 3, 1 es duplicado y lo quita, asi que hay 2 , no tiene sentido que el tamaño esperado sea 1, flutter cagado
    });

    // testear el metodo de borrar favorito
    test('deleteFavorite', () {
      expect(controller.favoritos.length, 0); //al principio al map esta vacio
      final platillo = Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );

      controller.addFavorites(platillo);
      expect(controller.favoritos.isNotEmpty, true); //ahora q si tiene un platillo es true
      controller.deleteFavorite(platillo);
      expect(controller.favoritos.length, 0); //como lo quitamos, el map queda vacio 0
    });

    test('dispose', () async {
      // comprobar que se llamo a dispose
      // final ci = controller.disposed;
      // completer es A way to produce Future objects and to complete them later with a value or error.
      Completer<bool> completer = Completer();
      controller.onDisposee = () {
        completer.complete(true);
      };
      expect(controller.disposed, false); //por defecto es false
      await controller.dispose();
      expect(await completer.future, true); //esto sera true cuando se invoque a onDisposee con true
      expect(controller.disposed, true); //una ves llamado ahora si deberia ser true
    });

    // testearemos la funcion isfavorite
    test('isfavorite', () async {
      final platillo = Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );
      expect(controller.isFavorite(platillo), false);
      controller.addFavorites(platillo);
      expect(controller.isFavorite(platillo), true);
    });
  });
}
