import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_controller.dart';
import 'package:delivery_food/src/ui/pages/forgot_password/widgets/form_forgot_password.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordController>(
        create: (context) => ForgotPasswordController(),
        builder: (context, __) {
          //esto es para q no tengamos ese error de overflow cuando ponemos el teclado
          final MediaQueryData data = MediaQuery.of(context);
          final Size size = MediaQuery.of(context).size; //con esto obtenemos las dimensiones de la pantalla
          final padding = data.padding;

          return Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.transparent,
              // elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(), //para q pueda salirse del input dando click en otro lado
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent, //necesario para el unfocus
                    constraints: BoxConstraints(
                      //la altura de la pantalla menos sector de noficicaciones y barra de home
                      minHeight: size.height - padding.top - padding.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "Olvido su contraseña",
                          style: FontStyles.titulo.copyWith(
                            fontSize: 22.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                          child: Text(
                            "tu cuentra se enviara a lorem ipsum",
                            style: FontStyles.normal.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const ForgotPageForm(),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
