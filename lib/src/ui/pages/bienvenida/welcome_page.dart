// import 'package:delivery_food/src/pages/register/register_page.dart';
// ignore_for_file: sized_box_for_whitespace

import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/circle_button.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
// import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
// import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  // child: SvgFromAsset(path :"assets/pages/welcome/welcome2.svg"), no usado
                  child: SvgPicture.asset(
                    "assets/pages/welcome/welcome2.svg",
                    //width: 200,
                  ),
                ),
              ),
              Text("Bienvenido", style: FontStyles.titulo),
              const SizedBox(height: 20.0),
              Text(
                "Al contrario del pensamiento popular,\n el texto de Lorem Ipsum no es simplemente texto aleatorio. \nTiene sus raices en una pieza clasica de la literatura del Latin",
                style: FontStyles.normal,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              ConstrainedBox(
                // ConstrainedBoxmaneja el tamaaños de sus wigets hijos
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //nuestro boton
                    Expanded(
                      child: RoundedButton(
                        onPressed: () async {
                          // Navigator.pushReplacementNamed(context, Routes.Login);
                          await _setReady(); //nuestra funcion q asignamos q es true y no tendra q visitar las anteriores paginas otra ves
                          Navigator.pushNamed(context, Routes.Login);
                        },
                        label: "Login",
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: RoundedButton(
                        onPressed: () async {
                          await _setReady();
                          Navigator.pushNamed(context, Routes.Register);
                        },
                        label: "Registrarse",
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                        borderColor: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Text("O ingresa via", style: FontStyles.normal),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    onPressed: () {},
                    iconPath: "assets/pages/welcome/facebook.svg",
                    backgroundColor: Colors.blueAccent,
                  ),
                  const SizedBox(width: 10),
                  CircleButton(
                    onPressed: () {},
                    iconPath: "assets/pages/welcome/google.svg",
                    backgroundColor: Colors.redAccent,
                  ),
                  const SizedBox(width: 10),
                  CircleButton(
                    onPressed: () {},
                    iconPath: "assets/pages/welcome/apple.svg",
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

// metodo asignamos ready, con el metodo setonborardAndWelcomeready truee
  Future<void> _setReady() {
    return Get.i.find<PreferencesRepository>().setOnboardAndWelcomeReady(true); //y le pasamos trueeee
  }
}
