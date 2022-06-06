// ignore_for_file: implementation_imports

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/helpers/get.dart';
// import 'package:delivery_food/src/helpers/get.dart';

import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/input_text.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
import 'package:delivery_food/src/ui/pages/login/login_controller.dart';
import 'package:delivery_food/src/utils/dialogs.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context, listen: false); //con false no se va a volver a dibujar el loginform
    return ConstrainedBox(
      //ConstrainedBox es para controlar el tamaños de varios wigets
      constraints: const BoxConstraints(maxWidth: 340.0),
      child: Column(
        children: [
          //nuestro input
          InputText(
            labelText: "Correo electronico",
            prefixIcon: const Icon(Icons.email_rounded),
            keyboardType: TextInputType.emailAddress,
            validator: (text) {
              //text hace referencia a los que esta escrito en el input
              if (text.contains("@")) return null;
              //sino
              return "email invalido";
            },
            onChanged: controller.onEmailChanged, //(text) {},
          ),
          const SizedBox(height: 20),
          InputText(
            labelText: "Contraseña",
            prefixIcon: const Icon(Icons.lock_outline),
            obscureText: true,
            onChanged: controller.onPasswordChanged, //(text) {}, //pa recupera el dato de la contraseña
            onSubmitted: (texto) => _submit(context), //y con esto ahora con solo de enter en el teclado ira a submit
          ),
          Align(
            //align, widget para elinear lo que este dentro
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              child: Text(
                "Olvido su contraseña?",
                style: FontStyles.normalnegrito,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.Forgot);
              },
            ),
          ),
          const SizedBox(height: 20),
          RoundedButton(
            onPressed: () {
              //
              return _submit(context);
            },
            label: "login",
            fullWidth: false,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 9),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = context.read<LoginController>();
    ProgressDialog.show(context); //nuestro widget, para mostrar un iconito de carga
    final User? user = await controller.submit();
    Navigator.pop(context);
    if (user == null) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email o contraseña invalido"),
        ),
      );
    } else {
      // guardamos|inyectamos el usuario antes de navegar a home C:
      Get.i.put<User>(user); //agregado - pa subir|inyectar nuestro user y poder ocuparlo en otro lado
      //pasa normal a home
      Navigator.pushNamedAndRemoveUntil(context, Routes.Home, (route) => false); //si es false elimina las pags del stack
    }
    //pa que escuche los cambios de losgincontroller gracias a que el widget padre es un ChangeNotifierProvider
    //context.read no se puede utilizar dentro del build
  }
}
