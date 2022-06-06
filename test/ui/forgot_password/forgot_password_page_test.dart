// ignore_for_file: unused_local_variable
// siempre hacer q el test de error y luego ya probar

import 'package:delivery_food/src/ui/global_widgets/input_text.dart';
// import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_controller.dart';
import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  //inicialiamos nuestras dependencias al principio
  setUpAll(() async {
    TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

  testWidgets("forgotpassword page", (WidgetTester tester) async {
    GlobalKey<NavigatorState>? navigatorKeyy = GlobalKey(); //definimo cmo llave global
    //inyectamos el widget principal de la page
    await tester.pumpWidget(MaterialApp(
      home: const ForgotPasswordPage(),
      // con esto podemos navegar sin contexto
      navigatorKey: navigatorKeyy,
    ));
    final router = navigatorKeyy.currentState!;

    final buttonFinder = find.text("Enviar"); //buscamos el widget que tenga  el texto enviar
    await tester.tap(buttonFinder); //hacemos tap
    // email invalido
    await tester.pump(); //pa cambiar el frame pa q renderize

    // mostrara dialogo de invilado
    expect(find.text("Email invalido"), findsOneWidget); //nos deveria decir email invalido y funciona, findsNothing daria error
    router.pop(); //seria como un navigator.pop
    await tester.pump();
    // dialogo ya quitado  y ya no apareceria esto
    expect(find.text("Email invalido"), findsNothing); //con findsOneWidget esto daria error

    await tester.enterText(
        find.byType(InputText), "test@test.com"); //asi insertamos texto en el widget inputText, pk solo hay 1 en esta pagina

    await tester.pump();
    expect(find.text("test@test.com"), findsOneWidget); //con findsNothing fallaria pk si hay ese
    await tester.tap(buttonFinder); //hacemos tap
    await tester.pump(const Duration(milliseconds: 2100)); //q renderize
    expect(find.text("Exito"), findsOneWidget); //nos apareceria el dialogo de exito , pasa el test
  });
}


// simular servicios, el conportamiento de esos servicios o generar datos ficticios, a eso se le llama Moc
// usaremos mockito