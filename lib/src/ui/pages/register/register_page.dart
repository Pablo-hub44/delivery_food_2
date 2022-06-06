import 'package:delivery_food/src/ui/pages/register/register_controller.dart';
import 'package:delivery_food/src/ui/pages/register/widgets/register_form.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterController>(
        create: (_) => RegisterController(),
        builder: (_, __) {
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
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(), //para q pueda salirse del input dando click en otro lado
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    constraints: BoxConstraints(
                      //la altura de la pantalla menos sector de noficicaciones y barra de home
                      minHeight: size.height - padding.top - padding.bottom,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Registrarse",
                          style: FontStyles.titulo.copyWith(
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "LLena lo sig. y crea tu cuenta",
                          style: FontStyles.normal.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 55),
                        const RegisterForm(),
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
