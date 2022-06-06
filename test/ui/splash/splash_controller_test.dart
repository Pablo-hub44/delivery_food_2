// ignore_for_file: avoid_print, unused_local_variable

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/local/preferences_provider.dart';
import 'package:delivery_food/src/data/providers/remote/account_provider.dart';
import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/account_repository.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/pages/splash/splash_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

// @GenerateMocks([AuthenticationProvider, AuthenticationClient, AccountProvider])
// de los de generate mocks luego de eso ponemos flutter pub run build_runner build en consola, ya no usado
void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); //como el WidgetsFlutterBinding q poniamos en el main
  // se ejecutara al principio, se usa mas para inicializar variables, declarar constantes etc
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({}); //inicializar sharedpreferences para testear ya q ocupa codigo nativo
    final preferences = await SharedPreferences
        .getInstance(); //el sharedpreferencer retorna un Future por ello ponermo el async y await y es el dato que le tenemos q pasar de pararametro en prefsprovider

    final PreferencesProvider preferencesProvider =
        PreferencesProvider(preferences); //instancia de provider, para pasarsela a la impl

    Get.i.put<PreferencesRepository>(PreferencesRepositoryImpl(preferencesProvider));
    // -----
    final authenticationProvider = AuthenticationProvider();
    final authenticationClient = AuthenticationClient(preferences);
    Get.i.put<AuthenticationRepository>(AuthenticationRepositoryImplementation(authenticationProvider, authenticationClient),
        tag: "auth");
    // -----

    final accountProvider = AccountProvider(authenticationClient);
    Get.i.put<AccountRepository>(
        AccountRepositoryImpl(accountProvider)); //hamos todos los put necesarios con laas propiedades q necesita
  });
  // -----
  tearDownAll(() {
    Get.i.clear(); //para que al final de todos estos test , limpie las dependencias inyectadas
  });
  // metodo para testesar el metodo afterfirstloyout
  group('afterfirstLayout', () {
    // testeat cuando el token es nulo
    test('token == null && isReady false', () async {
      addTearDown(() async {
        await Get.i.find<PreferencesRepository>().setOnboardAndWelcomeReady(true); //pa q espere a ejecutar esta tarea
      });

      // si el test tiene dependencias inyectadas (.i.find..) se tienen q agregar todas
      final controller = SplashController();
      // completer es A way to produce Future objects and to complete them later with a value or error.
      final Completer<void> completer = Completer();
      controller.onafterFirstLayout = (User? user, bool isReady) {
        expect(user == null, true); //como no tenemos nada en shaed preferences user no existe, por eso user == null es true
        expect(isReady, false); //como no tenemos nada en shaed preferences user no existe, isready deberia ser false
        completer.complete(); //asi ponemos el completer como completado
      };
      // ese metodo onafterfirstlayout se llamaba cuando la pantalla de spalsh ha sido renderizada al menos una ves
      controller.afterFirstLayout();
      await completer.future; //para q ejecute el future q esta dentro de afterfirstlayout
    });

    test('token == null && isReady true', () async {
      addTearDown(() async {
        await Get.i.find<AuthenticationRepository>(tag: 'auth').saveToken("tokensito");
      });

      // si el test tiene dependencias inyectadas (.i.find..) se tienen q agregar todas
      final controller = SplashController();
      // completer es A way to produce Future objects and to complete them later with a value or error.
      final Completer<void> completer = Completer();
      controller.onafterFirstLayout = (User? user, bool isReady) {
        expect(user == null, true); //como no tenemos nada en shaed preferences user no existe, por eso user == null es true
        expect(isReady, true); //como al finalizar el anterior test le agregamos el preferences repo ahora debe devolver true
        completer.complete(); //asi ponemos el completer como completado
      };
      // ese metodo onafterfirstlayout se llamaba cuando la pantalla de spalsh ha sido renderizada al menos una ves
      controller.afterFirstLayout();
      await completer.future; //para q ejecute el future q esta dentro de afterfirstlayout
    });

    test('token != null', () async {
      // si el test tiene dependencias inyectadas (.i.find..) se tienen q agregar todas
      final controller = SplashController();
      // completer es A way to produce Future objects and to complete them later with a value or error.
      final Completer<void> completer = Completer();
      controller.onafterFirstLayout = (User? user, bool isReady) {
        expect(user == null, false); //como si pusimos un find con token, user no es nulo , por eso es false

        completer.complete(); //asi ponemos el completer como completado
      };
      // ese metodo onafterfirstlayout se llamaba cuando la pantalla de spalsh ha sido renderizada al menos una ves
      controller.afterFirstLayout();
      await completer.future; //para q ejecute el future q esta dentro de afterfirstlayout
    });
  });
}
