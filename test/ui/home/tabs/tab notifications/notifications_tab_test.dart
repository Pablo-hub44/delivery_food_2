import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/notifications_tab/widgets/notification_item.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/home_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../dependency_injection.dart';
import '../../../../mock/mock_websocket_provider.dart';
import '../mock_pages.dart';
// import '../sleep.dart';

void main() {
  //inicialiamos/inyectamos nuestras dependencias al principio
  setUpAll(() async {
    await TestDependencyInjection.initialize();
    Get.i.put<WebsocketRepository>(WebsocketRepositoryImpl(MockWebSocktProvider(
        1000))); //le pasamos los milisegundos, como lo pusumos como opcional no hace conflicto nada de lo echo annntes, le ponemos un tiempode espera
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

  testWidgets('notifications tab', (tester) async {
    // mockNetworkImages puesto pk ocupamos imagenes de internet , aunqye testwidgets ya lo defecta sin problemas
    await mockNetworkImages(() async {
      await tester.pumpWidget(mockPages()); //mockpages donde traemos homepage pa poder testear
      // ---- codigo para ir a otra tab
      final tabsfinder = find.descendant(
          of: find.byType(HomeButtonBar),
          matching: find.byType(Tab)); //buscamos el tab pa acceder a los botones y luego irnos a notificaciones
      // tabsfinder.at(2); //al elemento en la pos 2
      await tester.tap(tabsfinder.at(2)); //hacemos tab en notificaciones
      await tester.pumpAndSettle(const Duration(milliseconds: 310)); //ya estamos en la pestaña de favoritos
      // ----
      expect(find.byType(NotificationItem), findsNothing); //al principio no hay nada, findwdgets daria error
      await tester.pumpAndSettle(const Duration(milliseconds: 300)); //le damos mas tiempo
      expect(find.byType(NotificationItem), findsWidgets); //findsnothing daria error, pk ahora ya hay notiitems
    });
  });
}
