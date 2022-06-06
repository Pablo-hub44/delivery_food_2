import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// el iconito de cargando :D, abstract pa que no pueda ser instanciada
abstract class ProgressDialog {
  //metodo|funcion
  static Future<void> show(BuildContext context) {
    // assert(context != null); //validamos que context no sea nulo, yano necesario pk no puede ser nulo
    return showCupertinoModalPopup(
      //antes showDialog(, cambiado pk se ve mejor
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false, //false = que no se pueda salir de la espera de 2seg
        child: Container(
          width: double.infinity, //los dialogos se comportar como una ruta
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.white30,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

//clase de un dialogo
abstract class Dialogs {
  //metodo
  static Future<void> alert(
    BuildContext context, {
    String? title,
    String? description,
    String okText = "ok",
    bool dismissible = true, //para el onwillpop que si sea bloqueable o no
  }) {
    // assert(context != null); //validamos que context no sea nulo , en una funcion Future :O
    return showCupertinoDialog(
      context: context,
      barrierDismissible: dismissible, //para el onwillpop que si sea bloqueable o no
      builder: (_) => WillPopScope(
        onWillPop: () async => dismissible, //para el onwillpop que si sea bloqueable o no ambos neces
        child: CupertinoAlertDialog(
          //entes AlertDialog(
          title: (title != null) ? Text(title) : null,
          content: (description != null) ? Text(description) : null,
          actions: [
            CupertinoDialogAction(
              // antes FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(okText),
            ),
          ],
        ),
      ),
    );
  }

  // dialogo metodo de confirmacion
  static Future<bool> confirm(
    BuildContext context, {
    String? title,
    String? description,
    String okText = "Entendido",
    bool dismissible = true, //para el onwillpop que si sea bloqueable o no
  }) async {
    final result = await showCupertinoModalPopup<bool>(
        context: context,
        //willpopscope con este widget en false sabemos q no se va a minimizar nuestro dialogo, a menos q de click en el boton
        builder: (context) => WillPopScope(
              // CupertinoActionSheet , ocmo un cuadro de dialogo
              child: CupertinoActionSheet(
                title: (title != null) ? Text(title) : null,
                message: (description != null) ? Text(description) : null,
                actions: [
                  // accion de confirmar
                  CupertinoActionSheetAction(
                    child: Text(okText),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                  // accion de cancelar
                  CupertinoActionSheetAction(
                    child: const Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    isDestructiveAction: true,
                  ),
                ],
              ), //sheet = hoja de accion
              onWillPop: () async => false,
            ));
    return result ?? false; //?? null condition , noes nulo tomalo ?? sino toma este
  }
}



// no se puede utilizar const en widgets que como parametro un callback, una funcion
// solo se puede utilizar const en aquellos wigets en los cuales sus valores ya los conocemos