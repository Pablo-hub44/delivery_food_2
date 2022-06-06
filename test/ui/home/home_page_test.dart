// ignore_for_file: avoid_print

import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';

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

  testWidgets('homepage tabbarView', (tester) async {
    // envuelto en mocknetwork dependencia externa .. para q no de error las url de las imagenes , pero actualmente no es necesario igual funciona si lo quitamos
    mockNetworkImages(() async {
      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<MyCartController>(
          create: (_) => MyCartController(),
          builder: (_, __) => const HomePage(),
        ),
      ));

      // comprobando q existe en nuestro homepage un widget tabbarview
      final tabBarViewFinder = find.byType(TabBarView); //pk solo tenemos 1 tabbarview en homepage
      expect(tabBarViewFinder, findsOneWidget); //findsNothing daria error

      // con esto va a retornar un dato de tipo state, utilizaremos este contexto pa recuperar mi homeController
      // esto es posible pk el widget tabbarview extiende de un statefulwidget
      final homecontroller = tester.state(tabBarViewFinder).context.read<HomeController>();
      print(homecontroller.actualPage);

      // obteniendo el label de uno de los botones (al del corazon| favoritos)
      final favorites = homecontroller.items[1].label; //accedemos al item en la pos 1 (el de corazon) | referencia al boton

      final favorietesTabFinder = find.byKey(Key(favorites));
      await tester.tap(favorietesTabFinder); //damos click en la pestaña del corazon

      await tester.pumpAndSettle(const Duration(milliseconds: 310)); //rederizamos al sig frame, y le damos el tiempo necesario
      print(homecontroller.actualPage);
      expect(homecontroller.actualPage, 1); //la pag actual ahora es la pos 1, y por ello pasa
    });
  });
}
