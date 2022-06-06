import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget mockPages({Widget? home, Map<String, Widget Function(BuildContext)>? routes}) {
  // micartcontroller lo tenemos como controller de estado global
  return ChangeNotifierProvider<MyCartController>(
    create: (_) => MyCartController(),
    builder: (_, __) => MaterialApp(
      home: home ?? const HomePage(),
      routes: routes ?? {},
    ),
  );
}
