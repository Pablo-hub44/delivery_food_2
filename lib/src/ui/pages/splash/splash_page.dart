// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashController>(
      lazy: false,
      create: (context) {
        final controller = SplashController();

        //con esto hara que nuestra pagina renderize sin problema, que tome su tiempo, y q renderize al menos una ves
        WidgetsBinding.instance!.addPostFrameCallback((context) {
          controller.afterFirstLayout(); //
        });
        // si isReady es true, q navegue a tal pantalla y tambien le pasamos user
        controller.onafterFirstLayout = (user, isReady) {
          String routeName = isReady ? Routes.Login : Routes.Onboard;
          //inyectamos la dependencia y la cambiamos a true
          Get.i.put<bool>(true, tag: 'after-splash');
          // si hay user guardado en sharedpreferences ... q valla a home
          if (user != null) {
            routeName = Routes.Home;
            Get.i.put<User>(user); //guardamos el usuario y lo ponemos disponible a inyecc de dependencia
          }
          Navigator.pushReplacementNamed(context, routeName); //routename sera dependendiendo las condiciones
        };

        return controller;
      },
      builder: (context, __) => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
