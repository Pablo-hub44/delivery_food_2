// ignore_for_file: implementation_imports

import 'package:delivery_food/src/ui/global_widgets/input_text.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
// import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_controller.dart';
import 'package:delivery_food/src/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class ForgotPageForm extends StatelessWidget {
  const ForgotPageForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ForgotPasswordController>();
    return ConstrainedBox(
      //darle el tamaño a un conjunto de widgets
      constraints: const BoxConstraints(maxWidth: 330), //ancho maximo, como un paddin horizontal
      child: Column(
        children: [
          const SizedBox(height: 15),
          // svgpicture ya es compatible con web
          // SvgFromAsset(path: "assets/pages/forgotpassword/img4.svg"),//widget propio pa ver si usar el image.network o svgpicture, no usado
          SvgPicture.asset(
            "assets/pages/forgotpassword/img4.svg",
            width: 250,
          ),
          const SizedBox(height: 45),
          InputText(
            // key: Key('forgot--password'),
            prefixIcon: const Icon(Icons.email_rounded),
            labelText: "Email",
            onChanged: controller.onEmailChanged, //onEmailChanged cumple la estructura de onChanged
            keyboardType: TextInputType.emailAddress,
            validator: (text) {
              //text hace referencia a los que esta escrito en el input
              if (text.contains("@")) return null;
              //sino
              return "email invalido";
            },
          ),
          const SizedBox(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: RoundedButton(
              onPressed: () {
                _submit(context);
              },
              label: "Enviar",
              fullWidth: false,
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) async {
    //async pa que espere la ejecucion del await
    final controller = context.read<ForgotPasswordController>();
    // validamos
    if (controller.email.contains("@")) {
      ProgressDialog.show(context); //nuestro widget, para mostrar un iconito de carga
      final send = await controller.submit();
      Navigator.pop(context);
      if (send) {
        //widget propio
        await Dialogs.alert(
          context,
          title: "Exito",
          description: "Se ha enviado el email ${controller.email}",
          dismissible: false, //bloquear salidas qeu no sean el boton
        );
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Error"),
            content: Text("email ${controller.email} no encontrado"),
          ),
        );
      }
    } else {
      //sino es validmo entonces dialogo de error
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email invalido"),
        ),
      );
    }

    //pa que escuche los cambios de logincontroller gracias a que el widget padre es un ChangeNotifierProvider
    //context.read no se puede utilizar dentro del build | read solo recuperamos el dato
  }
}
