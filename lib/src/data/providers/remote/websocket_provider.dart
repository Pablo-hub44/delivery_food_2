// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';

import 'package:delivery_food/src/data/modelos/notification.dart';
import 'package:faker/faker.dart';

class WebsocketProvider {
  WebsocketProvider() {
    print("websocketProvider:::"); // acada que se cree una instancia de websokect mostrara esto
  }

  // funcion para conectarnos al websocket
  //el future nos permite esperar (await) a que termine la tarea
  // future osease codigo q va a tener un tiempo y q va a esperar lo que este en await
  Future<void> connect(String uri) async {
    await Future.delayed(Duration(seconds: 2)); //darle un tiempo de 2 seg
    _init();
  }

  // el streamcontroller con broadcast q podra oir muchos .listens
  final StreamController<AppNotification> _controller = StreamController.broadcast();
  Timer? _timer; //propiedad que ocuparemos para darle tiempos a algo, lo usaremos pa las notificaciones

  // el contructor de la clase
  // WebsocketProvider() {} yano hace falta esto ya q antes tenia a init(), ahora se inicializa en conecct

  _init() {
    _timer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        // crearemos nuestra notificaciones ficticeas
        final faker = Faker();
        //crear la notificacion con base de nuestro modelo
        final notification = AppNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: "${faker.lorem.word()} ${faker.lorem.word()}",
          description: faker.lorem.sentence(),
          content: {},
          createdAt: DateTime.now(),
        );
        _controller.sink.add(notification); //se lo pasamos al streamController para q lo escuche la 'notificacion'
      },
    );
  }

  Stream<AppNotification> get onNotification =>
      _controller.stream; //asi conseguimos la propiedad privada de _controller y q escucharemos con stream

  //funcion para desconectanos del websocket
  Future<void> disconnect() async {
    _timer?.cancel();
    //detenemos las escucha del controller streacontroller, ya no dejaria de escuchar el streamcontroller, igual a dispose
    // await _controller.close();
    await Future.delayed(Duration(seconds: 1)); //darle un tiempo de 1 seg
  }

  Future<void> dispose() {
    // print("▲▲ dispose provider");
    return _controller.close(); //aca detenemos la escucha
  }
}
