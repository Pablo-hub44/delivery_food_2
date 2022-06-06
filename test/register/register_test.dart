// ignore_for_file: unused_local_variable, avoid_print, prefer_const_constructors

import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
import 'package:delivery_food/src/ui/pages/register/register_controller.dart';
import 'package:delivery_food/src/ui/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../dependency_injection.dart';

void main() {
  // se inicializa al principio
  setUpAll(() async {
    // inicializamos las dependencias necesarias, q estan en ese archivo que creamos antes
    await TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });
  group('RegisterController', () {
    late RegisterController controller;
    setUp(() {
      controller = RegisterController(); //asi le asigamos el valor y podremos usarlos en los demas test de este grupo
    });
    // que email,name,lastname sean nulos
    test("email, name & lastname no nulos", () {
      final controller = RegisterController();
      expect(controller.email, ''); //deberian ser un string vacio y todo bien
      expect(controller.name, '');
      expect(controller.lastname, '');

      controller.onEmailChanged("hola@test.com"); //le pasamos datos en sus pasametros
      controller.onNamelChanged("Pablo");
      controller.onLastnameChanged("Osinaga");

      expect(controller.email, 'hola@test.com'); //como le pasamos datos, ya no estan vacios
      expect(controller.name, 'Pablo');
      expect(controller.lastname, 'Osinaga');
    });

    test("submit", () async {
      // tenemos q volverlo ya que el setup se vuelve a ejecutar y reescribir al principio de cada test del grupo
      controller.onEmailChanged("hola@test.com"); //le pasamos datos en sus pasametros
      controller.onNamelChanged("Pablo");
      controller.onLastnameChanged("Osinaga");
      final result = await controller.submit();
      // print(result);
      expect(result, true);
    });
  });

// para probar el global key
  group('GlobalKeyCustomFormState formkey ', () {
    testWidgets("Registerform", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
              // utilizaremos este contexto para navegar a la pagina de register
              builder: (context) {
            return TextButton(
              key: Key('homeButton'),
              child: Text(""),
              onPressed: () {
                Navigator.pushNamed(context, Routes.Register);
              },
            );
          }),
        ),
        routes: {
          'register': (context) => RegisterPage(),
        },
      ));

      // de la pagina de home hacemos tap pa ir a pa pagina de register
      await tester.tap(find.byKey(Key('homeButton'))); //hace tap en el boton que tiene homeButton
      await tester.pumpAndSettle(Duration(microseconds: 300));

      final buttonFinnder = find.byType(RoundedButton); //busque el boton registrarse de tipo RoundenButton
      expect(buttonFinnder, findsOneWidget); //pa que testee si hay el button
      await tester.tap(buttonFinnder); //como esta vacio los datos mostrara el dialog de input invalidos
      await tester.pump(); //volvemos a renderizar la pagina el sig frame
      expect(find.text("inputs invalidos"), findsOneWidget);
      expect(find.text("Error"), findsOneWidget);

      await tester.tap(find.text("ok"));
      await tester.pump();

      // expect(find.text("inputs invalidos"), findsOneWidget);//esto ya no funcinaria pk el tialogo estaria minimizado
      // expect(find.text("Error"), findsOneWidget);

      //traemos los input por su key a aca
      final inputNameFinder = find.byKey(Key('register-name'));
      final inputLastnameFinder = find.byKey(Key('register-lastname'));
      final inputEmailFinder = find.byKey(Key('register-email'));
      // con entertext podemos pasarle datos a los campos
      await tester.enterText(inputNameFinder, "Pablo");
      await tester.enterText(inputLastnameFinder, "Osinaga");
      await tester.enterText(inputEmailFinder, "test@test.com");
      await tester.pump(); //volvemos a renderizar la pagina el sig frame
      expect(find.text("Pablo"),
          findsOneWidget); //comprobamos que encuentre un widget q tenga el texto Pablo, como lo pusimos anteriormente lo pasa
      expect(find.text("Osinaga"), findsOneWidget);
      expect(find.text("test@test.com"), findsOneWidget);

      await tester.tap(buttonFinnder); //mostrara un dialogo de exito
      await tester.pump(Duration(seconds: 2));

      expect(find.text("Registro exitoso"), findsOneWidget);

      await tester.tap(find.text("Ir a Login")); //al hacer tap ya estariamos de vuelta en la pagina de login
      await tester.pumpAndSettle(Duration(milliseconds: 300));
      expect(find.text("registrarse"), findsNothing); //findsOneWidget esto daria un error ya que no estamos ahi
    });
  });
}
