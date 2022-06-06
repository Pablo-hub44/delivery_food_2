// ignore_for_file: avoid_print

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/fav_tab/widgets/favorite_item.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/home_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../dependency_injection.dart';
import '../mock_pages.dart';
import 'package:provider/provider.dart';

void main() {
  //inicialiamos/inyectamos nuestras dependencias al principio
  setUpAll(() async {
    await TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

// vamosa testear favorites tab osea la vista
  testWidgets('favorites tab', (tester) async {
    mockNetworkImages(() async {
      await tester.pumpWidget(mockPages()); //mockpages donde esta la vista del principio, home
      final tabsfinder = find.descendant(
          of: find.byType(HomeButtonBar),
          matching: find.byType(Tab)); //buscamos el tabbar pa acceder a los botones y luego irnos a favoritos
      tabsfinder.at(1); //al elemento en la pos 1
      await tester.tap(tabsfinder.at(1)); //hacemos tab
      await tester.pumpAndSettle(const Duration(milliseconds: 310)); //ya estamos en la pestaña de favoritos
      expect(
          find.byType(FavoriteItem), findsNothing); //findsWidgets daria error pk al principio no hay ninguno agregado a favoritos
      final scaffoldContext =
          tester.state(find.byType(Scaffold)).context; //asi conseguimo el contexto del scaffold de la page de favss
      final homecontroller = scaffoldContext.read<HomeController>(); //escuchamos el homecontroller

      final platillo = Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      );
      homecontroller.addFavorites(platillo);
      await tester.pump();
      expect(find.byType(FavoriteItem), findsWidgets); //findsNothing daria error  ya que si agregamos a favoritos

      final firstFavorite =
          find.byType(FavoriteItem).first; //el primero pk podriamos tener mucho en favoritos y solo queremos uno para testear

      // final iconSlideActionfinderr = find.descendant(of: firstFavorite, matching: find.byType(IconSlideAction));
      // expect(iconSlideActionfinderr, findsWidgets);

      // ---- para a q encuentre el boton slidable el de eliminar
      // calcular el ancho de la pantalla
      final width = tester.getSize(find.byType(Scaffold)).width * 0.25;
      print(width); //es 200
      // simular la accion  de mover el item platillo a la izquierda para borrarlo, estamos en el tab de favorites
      await tester.drag(firstFavorite, const Offset(-200, 0));
      await tester.pumpAndSettle();
      expect(find.byType(IconSlideAction), findsWidgets); // findsNothing deberia dar error pk ya encontro el 'boton'
      await tester.tap(find
          .byType(IconSlideAction)
          .first); //first pk podria haber muchos items en favoritos, al hacer tap deberia eliminarse ese elemento
      await tester.pump();
      expect(find.byType(FavoriteItem), findsNothing); //findsWidgets daria error ya que fue borrado

      // vamos a testear una ves borrado el unico item que tenia, el map favorites este vacio osease 0
      expect(homecontroller.favoritos.length, 0);
    });
  });
}
