// import 'package:delivery_food/src/data/modelos/user.dart';
// import 'package:delivery_food/src/routes/routes.dart';
// ignore_for_file: implementation_imports, avoid_print, unnecessary_brace_in_string_interps

import 'package:delivery_food/src/ui/global_widgets/custom_form.dart';
import 'package:delivery_food/src/ui/global_widgets/input_text.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
import 'package:delivery_food/src/ui/pages/register/register_controller.dart';
import 'package:delivery_food/src/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return CustomForm(
      // CustomForm nuestro wiget, en ves de usar Form
      key: controller.formkey, //nuestra globalkey
      child: ConstrainedBox(
        //330 como ponerle un padding horizontal a todo el column
        constraints: const BoxConstraints(maxWidth: 330),
        child: Column(
          children: [
            InputText(
              key: const Key('register-name'), //ponemos las key pa poder testear
              //icono a la izquierda
              prefixIcon: const Icon(
                Icons.person_add_alt,
              ),
              labelText: "Nombre(s)",
              onChanged: controller.onNamelChanged,
              validator: (text) {
                return text.trim().length > 1
                    ? null
                    : "nombre invalido"; //trim pa q no cuente los espacios y tenga al menos 2 carateres
              },
            ),
            const SizedBox(height: 15),
            InputText(
              key: const Key('register-lastname'),
              //icono a la izquierda
              prefixIcon: const Icon(
                Icons.person_add_outlined,
              ),
              labelText: "Apellidos",
              onChanged: controller.onLastnameChanged,
              validator: (text) {
                return text.trim().length > 1
                    ? null
                    : "apellido invalido"; //trim pa q no cuente los espacios y tenga al menos 2 carateres
              },
            ),
            const SizedBox(height: 15),
            InputText(
              key: const Key('register-email'),
              //icono a la izquierda
              prefixIcon: const Icon(
                Icons.email_outlined,
              ),
              labelText: "Correo",
              onChanged: controller.onEmailChanged,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                return text.contains("@") ? null : "email invalido"; //que contenga el @
              },
            ),
            const SizedBox(height: 25),
            Align(
              //pa alinear nuestro widget
              alignment: Alignment.centerRight,
              child: RoundedButton(
                label: "Registrarse",
                fullWidth: false,
                onPressed: () {
                  _submit(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = context.read<RegisterController>(); //recuperamos registerController por el context
    final isFormOk = controller.formkey.currentState!.validate(); //los validator de los input
    print("el isokform ${isFormOk}");
    // validamos si el form cumple las validaciones, si si pasa a la segunda validacion
    if (isFormOk) {
      ProgressDialog.show(context); //nuestro widget, para mostrar un iconito de carga
      final bool isOk = await controller.submit();
      Navigator.pop(context);
      if (!isOk) {
        Dialogs.alert(context, title: "Error", description: "Error de registro");
        // showDialog( op2 el de arriba es widged propio
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Text("Error"),
        //     content: Text("Erro de registro"),
        //   ),
        // );
      } else {
        // si isok es true , dialogo de exito
        await Dialogs.alert(
          context,
          title: "Success",
          description: "Registro exitoso",
          dismissible: false, //false = bloquea
          okText: "Ir a Login",
        );
        Navigator.pop(context); //como esta en await , espera yva anav
        //isok es true, y ya login
        // showDialog( en anterior
        //   context: context,
        //   builder: (_) => WillPopScope(
        //       //widget WillPopScope para que no pueda retroceder a la pag anterior
        //       child: AlertDialog(
        //         title: const Text("Success"),
        //         content: Text("Registro exitoso"),
        //         actions: [
        //           FlatButton(
        //             onPressed: () {
        //               Navigator.popUntil(context, (route) => route.settings.name == Routes.Login);
        //               // return Navigator.pushNamed(context, Routes.Login);
        //             },
        //             child: Text("ok"),
        //           )
        //         ],
        //       ),
        //       onWillPop: () async => false), //false = bloquea
        // );
      }
      //pa que escuche los cambios de registercontroller gracias a que el widget padre es un ChangeNotifierProvider
      //context.read no se puede utilizar dentro del build
    } else {
      Dialogs.alert(context, title: "Error", description: "inputs invalidos");
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: Text("Error"),
      //     content: Text("inputs invalidos"),
      //   ),
      // );
    }
  }
}
