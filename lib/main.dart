import 'package:delivery_food/src/helpers/dependency_injection.dart';
import 'package:delivery_food/src/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //pa q inicialize la cosas de flutter primero antes de las dependencias
  // async y await pk ahora retorna un future void
  await DependencyInjection.initialize(); //antes de ejecutar la app, ejecutamos las dependencias
  runApp(const MyApp());
}
