// para sepa q si esta identificado
// import 'package:delivery_food/src/data/modelos/user.dart';
// ignore_for_file: unused_field

import 'package:delivery_food/src/data/repositorios/account_repository.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; //este paquete tiene una constante kisweb

// utilizar para envolver todas aquellasa paginas que requieren autenticacion
// para q cuando corramos en la web, no pueda poner rutas en la url y q le manden a tal lado sin que este 'autheticado'

class IsAuth extends StatefulWidget {
  final Widget page;
  const IsAuth({Key? key, required this.page}) : super(key: key);

  @override
  State<IsAuth> createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  // propiedades con estado cambiante
  late bool _initialized;
  final _authenticationRepository = Get.i.find<AuthenticationRepository>(tag: "auth"); //traemos el autenticationrepo
  final _accountRepository = Get.i.find<AccountRepository>(); //traemo el accounrepo

  @override
  void initState() {
    super.initState();
    final afterSplash = Get.i.find<bool>(tag: 'after-splash');
    // kisweb se utializa para saber si estamos corriendo la aplicacion en la web
    _initialized = !kIsWeb ||
        afterSplash; //kisweb es true cuando estamos corriendo el proyecto en la web, sino se esta corriend en la web sera false
    // validamos
    if (!_initialized) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        // vamos a redireccionar a la page de splash, pa q forzomente  a q pase por splash pa q realize la comprobacion y renderiza la page de home
        Navigator.pushReplacementNamed(context, Routes.Splash);

        // comprobar si el usuario ya inicio sesion previamente
        // final token = _authenticationRepository.token; //lo que seria el tal token del usuario
        // // validamos que no sea nulo el token, pa recuperar el accountrepo
        // if (token != null) {
        //   final user = await _accountRepository.userInformation;
        //   // validamos que user no sea nulo
        //   if (user != null) {
        //     Get.i.put<User>(user); //aca user no es nulo y lo inyectamos con put
        //     _initialized = true;
        //     setState(() {}); //rederizamos, pa q no se quede como container vacio
        //     //inyectamos la dependencia y la cambiamos a true pa q no nos muestre un bug de pantalla en blanco
        //     Get.i.put<bool>(true, tag: 'after-splash');
        //     return;
        //   }
        // }
        // Navigator.pushReplacementNamed(context, Routes.Login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return widget.page;
    } else {
      return Container();
    }
  }
}
