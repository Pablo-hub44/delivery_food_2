// se necesitara un statefull ya q se guardara el estado del contador

// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DishCounterSize { normal, mini } //pa poder elegir entre dos tipos de configuraciones

class DishCounter extends StatefulWidget {
  final void Function(int) onChanged; // notificar al widget padre que ha cambiado el valor del contador
  final DishCounterSize size; //pa cambiar el tamaño de los botoncitos
  final int initialValue; //pa poner el valor del contador
  const DishCounter({
    Key? key,
    required this.onChanged,
    this.size = DishCounterSize.normal,
    this.initialValue = 0,
  })  : //assert(size != null), //validamos que size no sea nulo
        assert(initialValue >= 0), //y que initial value sea mayor o igual a 0
        super(key: key);

  @override
  State<DishCounter> createState() => _DishCounterState();
}

class _DishCounterState extends State<DishCounter> {
  //atributos cambiantes :D
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue; //initialvalue le podra el valor a counter como estado inicial :D
  }

  @override
  Widget build(BuildContext context) {
    final bool mini = widget.size == DishCounterSize.mini; //para poder cambiar el tamaño,
    final double padding = mini ? 6 : 10;
    final double fontSize = mini ? 25 : 30;

    return Align(
      alignment: Alignment.center, //para centrar los botoncitos auunque este en un column start
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            child: Icon(Icons.add),
            color: Colors.grey,
            minSize: 20,
            padding: EdgeInsets.all(padding),
            borderRadius: BorderRadius.circular(30),
            onPressed: () {
              return _updateCounter(_counter + 1);
            },
          ),
          SizedBox(width: 10),
          Text("$_counter", style: FontStyles.normal.copyWith(fontSize: fontSize)),
          SizedBox(width: 10),
          CupertinoButton(
            child: Icon(Icons.remove),
            color: Colors.grey,
            minSize: 20,
            padding: EdgeInsets.all(padding),
            borderRadius: BorderRadius.circular(30),
            onPressed: () {
              return _updateCounter(_counter - 1); // q va a decrementar de 1 en 1 XD
            },
          ),
        ],
      ),
    );
  }

  //funcion para actualizar el valor del contador
  void _updateCounter(int counter) {
    //validar q solo renderize si es mayor a cero
    if (counter >= 0) {
      _counter = counter;
      setState(() {}); // para actualizar la vista :D
      widget.onChanged(_counter); //notificar q el contador ha cambiado
    }
  }
}

// 
// con el ValueListenableBuilder<> hace que no se renderize todo el stateful
// solo lo que tenemos en el valueaListenable , esa propiedades