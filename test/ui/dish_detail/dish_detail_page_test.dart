// ignore_for_file: avoid_print

import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/dish_counter.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/widgets/horizontal_dishes.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../dependency_injection.dart';
import '../home/tabs/mock_pages.dart';
import 'package:provider/provider.dart';

void main() {
  //inicialiamos/inyectamos nuestras dependencias al principio
  setUpAll(() async {
    TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

  testWidgets('DishdetailPage', (tester) async {
    // envuleto en dependencia externa, no es necesaria sepuede quitar
    mockNetworkImages(() async {
      //inyectamos el homepage, y con ella la home la pagina dishdetailpage
      await tester.pumpWidget(
        mockPages(routes: {
          Routes.Dish: (_) => const DishDetailPage(), //la pagina de un platillo especifico
        }),
      );
      // el boton de agrrgar al carrito inicialmente no debe ser visible
      expect(find.byType(FloatingActionButton), findsNothing); //findsWidgets daria error

      // para conseguir el tamaño
      print(tester.getSize(find.byType(Scaffold)));

      // vamos de la pagina de home a dishdetailpage
      final itemsFinder = find.byType(DishHomeItem); //buscamos por el tipo, en este caso dishhomeitem
      expect(itemsFinder, findsNothing); //se espera q lo encuentre, esta como hijo de horizontal dishes
      await tester.pump(const Duration(milliseconds: 310));
      expect(itemsFinder, findsWidgets); //findsNothing daria error, pk hay 2 DishHomeItem en horizontal dishes

      await tester.tap(itemsFinder.first); //hacemos un tap, first para que sea en el primer elemento pk como digimos hay 2
      await tester.pumpAndSettle(const Duration(milliseconds: 300)); //le damos un tiempo pa q renderize, sino no funcionara
      expect(find.text("Agregar al carrito"), findsOneWidget); //como encontro este boton es que ya estamos en la otra pagina

      // recuperar el controller de la pagina de dishdetailpage , con un winget q sea stateful pa recuperar el estado
      final scaffoldContext =
          tester.state(find.byType(Scaffold)).context; //utilizamos este context para recuperar el dishdetailcontroller
      final controller = scaffoldContext.read<DishController>();

      expect(controller.isFavorite, false); //seria false inicialmente

      final favoriteButtonfinder = find.byKey(const Key('favoritoov')); //conseguimo el boton de fav por el key

      expect(favoriteButtonfinder, findsOneWidget); //comprobamos q si encuentre el boton
      await tester.ensureVisible(
          favoriteButtonfinder); //lo q hace es va a simular hacer scroll hasta que nuestro boton esta en el area visible
      await tester.tap(favoriteButtonfinder); //hacemos tap ahi
      await tester.pump(); //renderizamos el frame
      expect(controller.isFavorite, true); //ya no es false, pk hicimos tap, ahora es true, esta agregado a favoritos

      // descendent va a permitir haceder a elementos hijos de un determinado finder, del dishcounter el boton
      final counterbuttonFinder = find.descendant(of: find.byType(DishCounter), matching: find.byType(CupertinoButton));
      // de esta manera sabremos cuantos elementos hay de cuperbutton en dishcounter, sabiendo eso sabemos , acceder al primero con first y al ultimo con last
      final nums = counterbuttonFinder.evaluate().length;
      print(nums);

      print(controller.dish.counter);
      await tester.tap(counterbuttonFinder.first); //damos click en el boton de +
      await tester.pump();
      print(controller.dish.counter);
      expect(controller.dish.counter, 1);
      await tester.tap(counterbuttonFinder.first); //damos click en el boton de +
      await tester.pump();

      expect(controller.dish.counter, 2); //ahora deben se 2 en el counter
      await tester.tap(counterbuttonFinder.last); //damos click en el boton de -
      await tester.pump();
      expect(controller.dish.counter, 1); //ahora deben ser 1

      await tester.tap(find.text("Agregar al carrito")); //hacemos tab en el boton de agregar al carrito
      await tester.pump();
      expect(find.text("Actualizar orden"), findsOneWidget); //al hacer tab ahora aparece este texto

      Navigator.pop(scaffoldContext); //volvemos a la pagina de home
      await tester.pumpAndSettle(const Duration(milliseconds: 300)); //renderizamos lo necesario
      expect(find.byType(FloatingActionButton), findsOneWidget); //findsNothing daria error
    });
  });
}

// test coverage nos permite saber el porcetaje de nuestro codigo q hemos testeado :O
// flutter test --coverage

// genhtml coverage/lcov.info -o coverage/html en mac
// en windows perl %GENHTML% -o coverage\html coverage\lcov.info, no funciona :,v
