// ignore_for_file: avoid_print

import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_controller.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Onboard controller', () {
    final controller = OnboardController(); //hacemos una instancia de tal
    // vamos a testeas que solo se pueda poner imagenes .svg
    test('.svg', () {
      // vamos a iterar en la lista con un for in,, item sera cada onboardItem
      for (final item in controller.items) {
        expect(item.image.contains(".svg"), true); //cada una de nuestras imagenes contiene .svg
      }
    });

// que el valor inicial sea cero, de inicio es cero
    test('currentPage initial value', () {
      expect(controller.currentPage, 0); //1 daria error
    });

    // testear el metodo afterfirtlayout, no usado , ya q usamos testwidget y ahora si funcionara
    // test('afterfirtlayout', () {
    //   controller.afterFirstlayout(); //escuchando los cambios
    //   controller.pageController.jumpToPage(1); //jumpToPageva a cambiar de pagina de nuestro pagecontroller, del pageview
    // });
  });

//

// aqui vamos a testear el widget osease la pagina de onboard
  group('Onboard page', () {
    // testwidgets es para testear widgets, retorna un future<void>
    // tester es el parametro  que nos va a permitir simular q estamos trabajando con vistas
    testWidgets("afterFirstLayout", (WidgetTester tester) async {
      // asi inyectamos un widget para poderlo testear
      await tester.pumpWidget(MaterialApp(
        home: const OnboardPage(),
        routes: {
          Routes.Welcome: (context) => Container(),
        },
      ));

      // propiedad de test de tipo finder, y de esta forma vamos a encontrar un widget utilizando un texto
      // find.text("Siguiente"); // vamos a buscar el boton a traves del texto q tiene
      // si ponemos un find.tex, de matcher tenemos que poner
      // - findsOneWidget q en obboardpage alla un widget tenga el texto siguiente, si encuentra dos o mas fallara
      // - findsnothing estamos diciendo que en onboardpage no deberia existir un widget con el texto Siguiente

      expect(find.text("Siguiente"), findsOneWidget);
      // expect(find.text("Siguiente"), findsWidgets); // findsWidgets que encuentre varios widgets con el texto siguiente , y pasara el test

      // entrar al evento cuando da y hace un click (ficticio xd) en el boton con el texto de siguiente
      await tester.tap(find.text("Siguiente")); //1
      // pumpAndSettle lo q hace es , simular volver a renderizar nuestro widget
      final result = await tester.pumpAndSettle(const Duration(milliseconds: 310));
      print(result); //podemos escuchar el evento addlistener de pagecontroller en onboard_controller.dart
      expect(find.text("Siguiente"), findsOneWidget); //sigue diciendo siguiente

      await tester.tap(find.text("Siguiente")); //2
      await tester.pumpAndSettle(const Duration(milliseconds: 310));

      expect(
          find.text("Comenzar"), findsOneWidget); //Siguiente daria error ya que al otro tap , ahora diria comenzar, no Siguiente
      await tester.tap(find.text("Comenzar")); //3
      // - pump igual hace volver a renderizar nuestro widget
      // - la diferencia entre pump y pumpAndsettle, pump solo renderiza al sig frame pocos frames, mientras q pumpsettle renderiza varios frames
      await tester.pumpAndSettle();
      // expect(find.text("Comenzar"), findsOneWidget);esto fallara, ya q al hacer tap en comenzar se va a otra pagina
      expect(find.text("Comenzar"), findsNothing); //pasara el expect, pk ya no hay boton con text comenzar
    });
  });
}
