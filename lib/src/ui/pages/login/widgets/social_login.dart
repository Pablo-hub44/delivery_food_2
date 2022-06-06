import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/circle_button.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//parte de la pag de login, no era necessario separarlo, solo fue para que no se acumulara todoen login page
class SocialLogin extends StatelessWidget {
  const SocialLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              "No tienes cuenta?",
            ),
            CupertinoButton(
              child: Text(
                "Registrarse",
                style: FontStyles.normalnegrito,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.Register);
              },
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
