// ignore_for_file: avoid_print

import 'package:delivery_food/src/ui/global_widgets/input_text.dart';
import 'package:flutter/material.dart';

//nuestro widget form
class CustomForm extends StatefulWidget {
  final Widget child;
  const CustomForm({Key? key, required this.child})
      : //assert(child != null), //validamos q child no sea nulo, ya no necesario
        super(key: key);

  @override
  State<CustomForm> createState() => CustomFormState();

  //funcion
  static CustomFormState? formState(BuildContext context) {
    return context.findAncestorStateOfType<CustomFormState>(); //con esto puede acceder al contexto del customform
  }
}

class CustomFormState extends State<CustomForm> {
  final Set<InputTextState> _fields = <InputTextState>{}; //escuchamos el estados del input_text

  @override
  Widget build(BuildContext context) {
    // Form(child: Text(''));
    return widget.child;
  }

  //metodos
  void register(InputTextState field) {
    _fields.add(field);
  }

  void remove(InputTextState field) {
    _fields.remove(field);
  }

  bool validate() {
    bool isOk = true;
    print("${_fields.length}");
    for (final item in _fields) {
      if (item.errorText != null) {
        //si se cumple esto signific que tenemos un error en el campo se texto
        isOk = false;
        break;
      }
    }
    return isOk;
  }
}
