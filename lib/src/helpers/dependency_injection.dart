// ignore_for_file: avoid_print

import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/local/preferences_provider.dart';
import 'package:delivery_food/src/data/providers/remote/account_provider.dart';
import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/providers/remote/food_menu_prodiver.dart';
import 'package:delivery_food/src/data/providers/remote/websocket_provider.dart';
import 'package:delivery_food/src/data/repositorios/account_repository.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/data/repositorios/food_menu_repo.dart';
import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
// import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

//creamos como un tipo de dato
typedef VoidCallback = void Function();

abstract class DependencyInjection {
  //metodo
  static Future<void> initialize() async {
    //mas info de shared en https://pub.dev/packages/shared_preferences/example
    final preference = await SharedPreferences.getInstance(); //guardara de forma local i think

    // declaramos los repos inplements con parametros de sus providers
    final AuthenticationRepository _authenticationRepository = AuthenticationRepositoryImplementation(
      AuthenticationProvider(),
      AuthenticationClient(preference),
    );

    final FoodMenuRepositoryImpl foodMenuRepository = FoodMenuRepositoryImpl(FoodMenuProvider());
////                                   (_authenticationRepository, tag: "auth");no ocupado ya q no ocupamos otros tipo igual a este
    ///
    // final wsProvider = WebsocketProvider(); //lo ponemos como variable provider | movido a lazyPut
    // final WebsocketRepositoryImpl websocketRepository = WebsocketRepositoryImpl(WebsocketProvider());
    // Get.i.put<WebsocketRepository>(websocketRepository);

    final PreferencesProvider preferencesProvider = PreferencesProvider(preference); //provider

    // creamos una instancia de autentication client
    final authenticationClient = AuthenticationClient(preference);

    final PreferencesRepositoryImpl preferencesRepository = PreferencesRepositoryImpl(preferencesProvider);

    final accountRepository = AccountRepositoryImpl(AccountProvider(authenticationClient));

    ///
// nuestras dependencias inyectadas, hay otras mas, no es necesario inyectarlas aqui
    Get.i.put<AuthenticationRepository>(_authenticationRepository, tag: "auth");
    Get.i.put<FoodMenuRepository>(foodMenuRepository);
    Get.i.put<String>("API_KEY", tag: "apikey");
    Get.i.put<String>("SECRET", tag: "secret");
    Get.i.put<PreferencesRepository>(preferencesRepository);
    Get.i.put<AccountRepository>(accountRepository);
    Get.i.lazyPut<WebsocketRepository>(() {
      final wsProvider = WebsocketProvider(); //lo ponemos como variable provider
      final WebsocketRepositoryImpl websocketRepository = WebsocketRepositoryImpl(wsProvider);
      return websocketRepository;
    });

    // su sonssera del is_auth
    Get.i.put<bool>(false, tag: 'after-splash');

    // hacemo una funcion de nombre y llamamos a dispose de wsprovider
    // ignore: prefer_function_declarations_over_variables
    final VoidCallback dispose = () {
      print("☻☻");
      // wsProvider.dispose();
    };

    Get.i.put<VoidCallback>(dispose, tag: 'dispose');
  }

  static void dispose() {
    final dispose = Get.i.find<VoidCallback>(tag: 'dispose'); //esto nos va a retornar lo q es la funcion
    dispose(); //y asi liberamos los recursos
  }
}
