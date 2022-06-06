// ignore_for_file: avoid_print

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/repositorios/account_repository.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter/cupertino.dart';

class SplashController extends ChangeNotifier {
  final _preferencesRepository = Get.i.find<PreferencesRepository>(); //traemos el preferencesrepo
  final _authenticationRepository = Get.i.find<AuthenticationRepository>(tag: "auth"); //traemos el autenticationrepo
  final _accountRepository = Get.i.find<AccountRepository>(); //traemo el accounrepo

  void Function(User? user, bool isReady)? onafterFirstLayout; //una variable tipo funcion

  void afterFirstLayout() async {
    await Future.delayed(const Duration(seconds: 2)); //le damos un tiempo

    final token = _authenticationRepository.token; //lo que seria el tal token del usuario
    // validamos que no sea nulo el token, pa recuperar el accountrepo
    if (token != null) {
      final user = await _accountRepository.userInformation;
      // validamos que user no sea nulo
      if (user != null) {
        if (onafterFirstLayout != null) {
          onafterFirstLayout!(user, true); //le pasamos el user y el true y le asignamos isready como parametro
          return; //con este return cerraria aca y ya no ejecutaria lo de abajo si q todo eso sea nulo
        }
      }
    }
    final isReady = _preferencesRepository.onboardAndWelcomeReady; //si isready es true naveguemos directamente a home
    print("isReady $isReady");
    // validamos q no sea nulo, con nuestro callback  si no hay token
    if (onafterFirstLayout != null) {
      onafterFirstLayout!(null, isReady); //le asignamos isready como parametro
    }
  }
}
