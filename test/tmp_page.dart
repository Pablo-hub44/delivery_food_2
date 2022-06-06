// esto solo es para probar el valueNotifier

// con el ValueListenableBuilder<> hace que no se renderize todo el stateful
// solo lo que tenemos en el valueaListenable , esa propiedades

// ignore_for_file: prefer_final_fields, avoid_print, unused_field, prefer_const_constructors, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';

class TmpPageState extends StatefulWidget {
  const TmpPageState({Key? key}) : super(key: key);

  @override
  State<TmpPageState> createState() => _TmpPageStateState();
}

class _TmpPageStateState extends State<TmpPageState> {
  //propiedades que tendran un estado cambiante
  // double _counter = 0;
  ValueNotifier<int> _counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          //  tiene que tener el mismo tipo de valor del ValueNotifier, con esto escucha solo los cambios de esa propiedad
          child: ValueListenableBuilder<int>(
            valueListenable: _counter, //le pasamos el valuenotifier, no puede ser null
            //el segundo parametro del builder es el valor actual del counter
            builder: (_, int value, child) {
              print("built text");
              return Column(
                children: [
                  Text("$_counter.value"),
                  // child, //asi tambien renderizada este widget child
                ],
              );
            },
            child: Builder(builder: (_) {
              print("print child");
              return Text("hijo $_counter.value"); //no se va a actualizar su valor pk esta en un  child, aqui solo renderiza 1vez
              // este child se usa mas para botones
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // _counter.value = _counter.value++;
        setState(() {
          //pa que renderiza los cambios de la propiedad cambiante del build
          _counter.value++;
        });
      }),
    );
  }
}

// --------- con una lista
class TmpPage extends StatefulWidget {
  const TmpPage({required Key key}) : super(key: key);

  @override
  State<TmpPage> createState() => _TmpPageState();
}

class _TmpPageState extends State<TmpPage> {
  // propiedades con estado cambiante :D
  ValueNotifier<List<int>> _data = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        //  tiene que tener el mismo tipo de valor del ValueNotifier, con esto escucha solo los cambios de esa propiedad
        child: ValueListenableBuilder<List<int>>(
          valueListenable: _data, //le pasamos el valuenotifier, no puede ser null
          //el segundo parametro del builder es el valor actual del counter
          builder: (_, List<int> data, child) {
            return ListView.builder(
              itemBuilder: (_, index) {
                //index hace referencia a la pos en la lista
                return ListTile(
                  title: Text("{data[index]}"),
                );
              },
              itemCount: data.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _data.value = DateTime.now().toString();
          final number = Random().nextInt(50); //num menor a 50
          // si quieres modificar la lista de ValueNotifier primero
          // 1. crear una copia de la lista
          final copy = List<int>.from(_data.value);
          // 2. a la copia le agregamos el nuevo valor
          copy.add(number);
          // 3. asignarle a nuestro valueNotifier, la copia
          _data.value = copy;
          // _data.value.add(number);
        },
      ),
    );
  }
}

// --------- con un Map
class TmpPage2 extends StatefulWidget {
  const TmpPage2({Key? key}) : super(key: key);

  @override
  State<TmpPage2> createState() => _TmpPage2State();
}

class _TmpPage2State extends State<TmpPage2> {
  // propiedades con estado cambiante :D
  ValueNotifier<Map<String, int>> _data = ValueNotifier({});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<Map<String, int>>(
        valueListenable: _data, //le pasamos el valuenotifier, no puede ser null
        //el segundo parametro del builder es el valor actual del _data
        builder: (_, Map<String, int> data, child) {
          final list = data.values.toList();
          return ListView.builder(
            itemBuilder: (_, index) {
              //index hace referencia a la pos en la lista
              return ListTile(
                title: Text("{list[index]}"),
              );
            },
            itemCount: data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _data.value = DateTime.now().toString();
          final number = Random().nextInt(50); //num menor a 50
          // si quieres modificar el map de ValueNotifier primero
          // 1. crear una copia del map
          final copy = Map<String, int>.from(_data.value);
          // 2. a la copia le agregamos el nuevo valor
          copy[DateTime.now().toString()] = number;
          // 3. asignarle a nuestro valueNotifier, la copia
          _data.value = copy;
          // _data.value.add(number);
        },
      ),
    );
  }
}

// -------- con una clase, instancias de una clase personalizada
class TmpPage3 extends StatefulWidget {
  const TmpPage3({Key? key}) : super(key: key);

  @override
  State<TmpPage3> createState() => _TmpPage3State();
}

class _TmpPage3State extends State<TmpPage3> {
  // propiedades con estado cambiante :D
  ValueNotifier<User?> _data = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<User?>(
        valueListenable: _data, //le pasamos el valuenotifier, no puede ser null
        //el segundo parametro del builder es el valor actual del _data
        builder: (_, User? user, child) {
          if (user == null) return Text("No encontrado"); //validar
          return Text("${user.name} ${user.age}");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _data.value = DateTime.now().toString();
          final number = Random().nextInt(50); //num menor a 50
          // _data.value.age = number;

          if (_data.value == null) {
            //validar si es nulo
            _data.value = User("Pablo", number);
          } else {
            //si no, modificamos su edad de essta forma
            _data.value = _data.value?.copyWith();
          }

          // si quieres modificar el map de ValueNotifier primero
          // 1. crear una copia del map
          // final copy = Map<String, int>.from(_data.value);
          // 2. a la copia le agregamos el nuevo valor
          // copy[DateTime.now().toString()] = number;
          // 3. asignarle a nuestro valueNotifier, la copia
          // _data.value = copy;
          // _data.value.add(number);
        },
      ),
    );
  }
}

// clase
class User {
  final String name;
  final int age;
  // constructor
  User(this.name, this.age);

  // funcion copia de la clase User, q va a retornar un User
  User copyWith({String? name, int? age}) {
    // retornamos un nueva instancia de User :D
    return User(name ?? this.name, age ?? this.age); //con null condition , si (name no es nulo tomalo ?? sino toma este)
  }
}
