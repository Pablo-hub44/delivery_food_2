import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/home_button_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../../../dependency_injection.dart';
import '../mock_pages.dart';

// raramente por defecto al testear , el test imagina q el dispositivo esta rotado y como el boton y lo q sea no esta a la vista, no funciona
void main() {
  //inicialiamos/inyectamos nuestras dependencias al principio
  setUpAll(() async {
    await TestDependencyInjection.initialize();
    // inyectamos un usuario ficticio
    Get.i.put<User>(User(
      id: "12342",
      name: "Pablo",
      lastname: "Osinaga",
      email: "test@test.com",
      cumple: DateTime(2000, 1, 1),
    ));
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

  // testeamos el profile tab
  testWidgets('profie tab', (tester) async {
    // mockimagen noes necesario
    mockNetworkImages(() async {
      // traemos la pagina de home q lo pusimo en mockpages, y agreamos a ruta de login pk la ocuparemos
      await tester.pumpWidget(mockPages(routes: {
        Routes.Login: (_) => Container(),
      }));
      final tabsfinder = find.descendant(
          of: find.byType(HomeButtonBar),
          matching: find.byType(Tab)); //buscamos el tab pa acceder a los botones y luego irnos a notificaciones
      // tabsfinder.at(3); //al elemento en la pos 3
      await tester.tap(tabsfinder.at(3)); //hacemos tab en perfil
      await tester.pumpAndSettle(const Duration(milliseconds: 310)); //ya estamos en la pestaña de perfil
      expect(find.text("Cerrar sesion"), findsOneWidget); //findsNothing daria error
      // para asegurarnos que si sea visible el boton de cerrar sesion y podamos hacer click
      await tester.ensureVisible(find.text("Cerrar sesion"));
      await tester.pump();
      await tester.tap(find.text("Cerrar sesion"));
      await tester.pumpAndSettle(); //rederizamos
      expect(find.text("accion requerida"), findsOneWidget); //el titulito del dialogo

      //nos posicionamos en los botones del dialog de CupertinoActionSheetaction, pa poder usar ok o cancelar, son 2
      Finder dialogbuttonsfinder =
          find.descendant(of: find.byType(CupertinoActionSheet), matching: find.byType(CupertinoActionSheetAction));

      // damos tap en cancelar
      await tester.tap(dialogbuttonsfinder.last);
      await tester.pumpAndSettle(); //rederizamos pa q se esconda el dialogo
      expect(find.text("accion requerida"), findsNothing); //daria error findsOneWidget, pk le dimos tap en cancelar

      // volvemos a hacer tap en cerrar sesion
      await tester.tap(find.text("Cerrar sesion"));
      await tester.pumpAndSettle(); //rederizamos

      // volvemos a posicionarmos en los actions
      dialogbuttonsfinder =
          find.descendant(of: find.byType(CupertinoActionSheet), matching: find.byType(CupertinoActionSheetAction));

      // damos tap en ok
      await tester.tap(dialogbuttonsfinder.first);
      await tester.pumpAndSettle(
          const Duration(milliseconds: 510)); //rederizamos pa q se esconda el dialogo, pa q navegue a la pagina de login
      expect(find.text("Cerrar sesion"), findsNothing); //findsOneWidget daria error pk ya no estamos en la page de perfil
    });
  });
}

// flutter web
// una progresive web application no es mas que ejecutar un sitio web como si fuera una aplicacion nativa o 
// una aplicacion movil, 

// flutter web opuca canvas kit para mostrar la aplicacion en la web

// flutter create . //crea la carpeta web

// modos de renderizado - al parecer hacen lo mismo :v
// flutter run -d edge //renderiza en modo canvas
// flutter run -d edge --web-renderer html, se va a renderizan en modo html

