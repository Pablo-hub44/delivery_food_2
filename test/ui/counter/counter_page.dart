// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // propiedades con estados cambiantes
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text("$counter"),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("TMP"),
          ),
          TextButton(
              key: const Key('add'),
              onPressed: () {
                counter++;
                setState(() {}); //para q vuelva a renderizar la vista 1,2,3,4,,,
              },
              child: const Text("Addd")),
        ],
      ),
    );
  }
}
