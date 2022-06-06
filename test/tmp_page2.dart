// esto solo es para probar el valueNotifier

// con el ValueListenableBuilder<> hace que no se renderize todo el stateful
// solo lo que tenemos en el valueaListenable , esa propiedades

// ignore_for_file: prefer_final_fields, avoid_print, unused_field, prefer_const_constructors, unused_local_variable

import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TmpPage2State extends StatefulWidget {
  const TmpPage2State({Key? key}) : super(key: key);

  @override
  State<TmpPage2State> createState() => _TmpPage2StateState();
}

class _TmpPage2StateState extends State<TmpPage2State> {
  //propiedades que tendran un estado cambiante
  // double _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // listview.builder , usado cuando hay q generar gran cantidad de widgets
      body: ListView.builder(
        itemBuilder: (context, index) => ExpensiveWidget(),
        itemCount: 25,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {});
      }),
    );
  }

  // otra forma, todo dentro del mismo build
  // pero lo recomendable es usar stateless o statefull para mejorar el rendimiento
  // metodo
  Widget buildItem() {
    // metodo dentro de un metodo jaja
    String generateText() {
      String text = "";
      final int number = Random().nextInt(100);

      for (int i = 0; i < number; i++) {
        text += "$i";
      }
      return text;
    }

    //return de la funcion principal
    return Card(
      child: Row(
        children: [
          Flexible(
            flex: 1, //con esto va a ocupar toda la pantalla
            child: Text(generateText()),
          ),
        ],
      ),
    );
  }
}

// widget para probar q de muchos junks en el devTools
class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(
            flex: 1, //con esto va a ocupar toda la pantalla
            child: Text(generateText()),
          ),
        ],
      ),
    );
  }

  //metodo
  String generateText() {
    String text = "";
    final int number = Random().nextInt(100);

    for (int i = 0; i < number; i++) {
      text += "$i";
    }
    return text;
  }
}

//isolates - son hilos aparte para el rendimiento de widget, tema avanzado
