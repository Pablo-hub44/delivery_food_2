import 'package:delivery_food/src/routes/routes.dart';
// import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
// import 'package:delivery_food/src/ui/pages/home/home_page.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/widgets/horizontal_dishes.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_page.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
// import 'package:provider/provider.dart';

import '../../../../dependency_injection.dart';
import '../mock_pages.dart';

void main() {
  // setupall se ejecuta al principio antes de todos los test y grupos
  setUpAll(() async {
    await TestDependencyInjection.initialize(); //inicializamos nuestras cosas
  });

  // teardownAll se ejecuta al final de todos los grupos y todos los test
  tearDownAll(() {
    TestDependencyInjection.clear();
  });

// cuando hacemos widgettesting no podemos hacer peticiones http o Rest
  testWidgets('home tab page', (tester) async {
    // ocupamos dependencia externa
    await mockNetworkImages(() async {
      // traemos nuesta page
      // await tester.pumpWidget(MaterialApp( antes, ahora se puso en mockHomePage
      //   home: ChangeNotifierProvider<MyCartController>(
      //     create: (_) => MyCartController(),
      //     builder: (_, __) => const HomePage(),
      //   ),
      // ));
      await tester.pumpWidget(mockPages(routes: {
        Routes.Dish: (_) => const DishDetailPage(), //la pagina de un platillo especifico
      }));
      final itemsFinder = find.byType(DishHomeItem); //buscamos por el tipo, en este caso dishhomeitem
      expect(itemsFinder, findsNothing); //se espera q lo encuentre, esta como hijo de horizontal dishes
      await tester.pump(const Duration(milliseconds: 310));
      expect(itemsFinder, findsWidgets); //findsNothing daria error, pk hay 2 DishHomeItem en horizontal dishes

      await tester.tap(itemsFinder.first); //hacemos un tap, first para que sea en el primer elemento pk como digimos hay 2
      await tester.pumpAndSettle(const Duration(milliseconds: 300)); //le damos un tiempo pa q renderize, sino no funcionara
      expect(find.text("Agregar al carrito"), findsOneWidget); //findsNothing daria error ya q si hay un widget con ese texto
    });
  });
}
