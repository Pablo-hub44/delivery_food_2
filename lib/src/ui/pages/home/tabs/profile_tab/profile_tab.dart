// ignore_for_file: sized_box_for_whitespace, unnecessary_import, prefer_const_constructors

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/data/repositorios/preferences_repository.dart';
import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
// import 'package:delivery_food/src/helpers/dependency_injection.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/utils/date_format.dart';
import 'package:delivery_food/src/utils/dialogs.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

// funcion de cerrar sesion,  se necisita el contexto para poder mostrar el dialogo
  void _signOut(BuildContext context) async {
    final isOk = await Dialogs.confirm(context, title: "accion requerida");
    if (isOk) {
      Get.i.remove<User>(); //removemos el user q estuviera guardado de put
      await Get.i.find<AuthenticationRepository>(tag: "auth").signOut(); //cerraramo tambien aca pa q se borre el 'token'
      await Get.i.find<PreferencesRepository>().setOnboardAndWelcomeReady(false); //ponemos a false la preferencesunavesqsesalga
      await Get.i
          .find<WebsocketRepository>(lazy: true)
          .disconnect(); //esperamos a q desconecte, luego limpie y ultimo navege a login
      context.read<NotificationsController>().clear(); //traemos el .clear de NotificationsController a aca con provider .read

      Navigator.pushNamedAndRemoveUntil(context, Routes.Login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.i.find<User>(); //ahora que user esta en get, podemos traer su info :O
    return Container(
      color: CupertinoColors.systemGroupedBackground, //el colors de fondo de ios settings
      // lista de vistas pero tambien se pudo haber ocupado SinglechildScrollView para no tener error de overflow
      child: ListView(
        children: [
          SizedBox(height: 20),
          Align(
            //hace que se vuelva un ovalo
            child: ClipOval(
              child: CachedNetworkImage(
                  width: 200,
                  height: 200,
                  imageUrl:
                      'https://img.freepik.com/vector-gratis/foto-perfil-personaje-dibujos-animados-avatar-mujer-joven_18591-55057.jpg'),
            ),
          ),
          // .insetGrouped quita las sombras preestrablecidas
          CupertinoFormSection.insetGrouped(
            margin: const EdgeInsets.all(15.0).copyWith(top: 0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            header: const Text("Informacion del usuario"),
            children: [
              CupertinoFormRow(
                // padding: EdgeInsets.only(right: 5),
                prefix: Text(
                  "ID",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(user.id),
              ),
              CupertinoFormRow(
                prefix: Text(
                  "Usuario",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text("${user.name} ${user.lastname}"),
              ),
              // campo para llenar
              CupertinoTextFormFieldRow(
                prefix: const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialValue: "test@test.com", //el valor inicial que se mostrara
                style: FontStyles.normal.copyWith(color: Colors.black),
                textAlign: TextAlign.right,
              ),
              CupertinoFormRow(
                prefix: Text(
                  "Cumpleaños", //va a ir del lado izquierdo
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  // user.cumple.toString(),
                  // user.cumple.format(user.cumple),
                  user.cumple.format,
                ),
              ),
            ],
          ),
          // otra seccion jeje
          CupertinoFormSection.insetGrouped(
            header: Text("Metodos de pago"),
            children: [
              CupertinoFormRow(
                prefix: Text("Tarjetas de credito", style: TextStyle(color: Colors.black)),
                child: CupertinoButton(
                  onPressed: () {},
                  minSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("Mostrar"),
                ),
              ),
              CupertinoFormRow(
                prefix: Text("Paypal", style: TextStyle(color: Colors.black)),
                child: CupertinoButton(
                  onPressed: () {},
                  minSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("tes@paypal.com"),
                ),
              ),
            ],
          ),
          //otra seccion
          CupertinoFormSection.insetGrouped(
            header: Text("Cuenta"),
            children: [
              CupertinoFormRow(
                prefix: Text("Borrar cuenta", style: TextStyle(color: Colors.black)),
                child: CupertinoButton(
                  onPressed: () {},
                  minSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("As click aqui para borrar", style: TextStyle(color: Colors.black)),
                ),
              ),
              CupertinoFormRow(
                prefix: Text("Sesion", style: TextStyle(color: Colors.black)),
                child: CupertinoButton(
                  onPressed: () {
                    _signOut(context);
                  },
                  minSize: 20,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Cerrar sesion",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    //AspectRatio widget para mantener las dimensines entre diferentes dispositivos
    //  AspectRatio(
    //     aspectRatio: 16 / 9, //muy usado para imgs y videos
    //     child: CachedNetworkImage(
    //         imageUrl:
    //             'https://img.freepik.com/foto-gratis/tortillas-frescas-primer-plano-envueltas-verduras-carne_23-2148614464.jpg?w=740',
    //         fit: BoxFit.cover),
    //   ),
  }
}
