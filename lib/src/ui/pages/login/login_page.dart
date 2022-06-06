// import 'package:delivery_food/src/global_widgets/circle_button.dart';
// import 'package:delivery_food/src/global_widgets/input_text.dart';
// import 'package:delivery_food/src/global_widgets/rounded_button.dart';

import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
import 'package:delivery_food/src/ui/pages/login/login_controller.dart';
import 'package:delivery_food/src/ui/pages/login/widgets/login_form.dart';
import 'package:delivery_food/src/ui/pages/login/widgets/social_login.dart';
// import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
      builder: (context, __) {
        //esto es para q no tengamos ese error de overflow cuando ponemos el teclado
        final MediaQueryData data = MediaQuery.of(context);
        final Size size = MediaQuery.of(context).size; //con esto obtenemos las dimensiones de la pantalla
        final padding = data.padding;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(), //para q pueda salirse del input dando click en otro lado
                child: Container(
                  color: Colors.transparent,
                  height: size.height - padding.top - padding.bottom, //700,
                  //padding.top es el espacio de la notificaciones y bottom del boton de home, esto pa que no haga scroll innecesario
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Container(
                      //   width: 200,
                      //   height: 100,
                      //   child: LayoutBuilder(
                      //     //LayoutBuilder ocupado para saber el tamaño de nuestro widget container
                      //     builder: (_, constraints) => Text("${constraints.maxWidth}, ${constraints.maxHeight}"),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Text(
                        "Bienvenido",
                        style: FontStyles.titulo.copyWith(
                          fontSize: 22.0,
                        ),
                      ),
                      Expanded(
                        // child: SvgFromAsset(path: "assets/pages/welcome/welcome1.svg",), no usado, pk svg si es compatible con la web
                        child: SvgPicture.asset(
                          "assets/pages/welcome/welcome1.svg",
                          //width: 200,
                        ),
                      ),
                      const LoginForm(), //widget propio

                      const SocialLogin(), //widget propio
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
