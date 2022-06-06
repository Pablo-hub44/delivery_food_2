// ignore_for_file: avoid_print, unused_local_variable

// import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/local/preferences_provider.dart';
// import 'package:delivery_food/src/data/providers/remote/account_provider.dart';
// import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/account_repository.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/data/repositorios/food_menu_repo.dart';
import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock/mock_account_provider.dart';
import 'mock/mock_authentication_client.dart';
import 'mock/mock_authentication_provider.dart';
import 'mock/mock_food_provider.dart';
import 'mock/mock_websocket_provider.dart';
// import 'ui/authentication_test.dart';
// import 'dart:async';

// ahora que lo pusimos es este archivo reparado, podemos llamarlo y no volver a poner todo esto
abstract class TestDependencyInjection {
  static Future<void> initialize() async {
    TestWidgetsFlutterBinding.ensureInitialized(); //como el WidgetsFlutterBinding q poniamos en el main

    SharedPreferences.setMockInitialValues({}); //inicializar sharedpreferences para testear ya q ocupa codigo nativo
    final preferences = await SharedPreferences
        .getInstance(); //el sharedpreferencer retorna un Future por ello ponermo el async y await y es el dato que le tenemos q pasar de pararametro en prefsprovider

    final PreferencesProvider preferencesProvider =
        PreferencesProvider(preferences); //instancia de provider, para pasarsela a la impl

    Get.i.put<PreferencesRepository>(PreferencesRepositoryImpl(preferencesProvider));
    // -----
    // final authenticationProvider = AuthenticationProvider();
    // final authenticationClient = AuthenticationClient(preferences);

    final authenticationProvider = MockAuthenticationProvider();
    final authenticationClient = MockAuthenticationClient(preferences);

    Get.i.put<AuthenticationRepository>(AuthenticationRepositoryImplementation(authenticationProvider, authenticationClient),
        tag: "auth");
    // -----

    // final accountProvider = AccountProvider(authenticationClient);
    final accountProvider = MockAccountProvider(
        authenticationClient); //con los data ya puesto reescritos para simular el comportamiento de dicha clase

    Get.i.put<AccountRepository>(
        AccountRepositoryImpl(accountProvider)); //hamos todos los put necesarios con laas propiedades q necesita

    // agragamos tambien la del websocketrepo
    Get.i.put<WebsocketRepository>(WebsocketRepositoryImpl(MockWebSocktProvider()));

    // agregamos tambien el de foodmenurepo
    Get.i.put<FoodMenuRepository>(FoodMenuRepositoryImpl(MockFoodMenuProvider()));
  }

  static clear() {
    Get.i.clear();
    Get.i.clearLazy();
  }
}
