// ignore_for_file: unused_element, unnecessary_this

import 'dart:async';

import 'package:delivery_food/src/data/modelos/notification.dart';
import 'package:delivery_food/src/data/providers/remote/websocket_provider.dart';
import 'package:faker/faker.dart';

class MockWebSocktProvider implements WebsocketProvider {
  final int? delay;
  // constructor
  MockWebSocktProvider([this.delay]); //q puede ser opcional
  // el streamcontroller con broadcast q podra oir muchos .listens
  final StreamController<AppNotification> _controller = StreamController.broadcast();
  Timer? _timer;

  @override
  Future<void> connect(String uri) async {
    await Future.delayed(Duration(milliseconds: this.delay ?? 0)); //si this.delay no es nulo tomalo, sino 0
    _init();
  }

  void _init() {
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
    _controller.sink.add(notification); //se lo pasamos al streamController para q lo escuche
  }

  @override
  Future<void> disconnect() async {
    _timer?.cancel();
    //detenemos las escucha del controller streacontroller, ya no dejaria de escuchar el streamcontroller, igual a dispose
    // await _controller.close();
    await Future.delayed(const Duration(seconds: 1)); //darle un tiempo de 1 seg
  }

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  @override
  Stream<AppNotification> get onNotification => _controller.stream;
}
