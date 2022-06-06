// estado global
// ignore_for_file: unused_field, unnecessary_this, avoid_print, prefer_final_fields

import 'dart:async';

import 'package:delivery_food/src/data/modelos/notification.dart';
import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter/widgets.dart';

class NotificationsController extends ChangeNotifier {
  // inyectamos la dependencia de websocketrepository, la traemos con .find | update le agregamos lazy pk es con lazyput
  final _wsRepository = Get.i.find<WebsocketRepository>(
      lazy: true); //gracias a esto se va a encargar de escuchar las notificaciones mediante nuestro stream

  late StreamSubscription _subscription;

  List<AppNotification> _notifications = []; //donde guardaremos las notificaciones
  List<AppNotification> get notifications => _notifications; //es dato es privado asi que lo conseguimos con get

  // con este streamcontroller emitiremos todas nuestras notificaciones, con varios listens
  StreamController<List<AppNotification>> _notificationsstreamController = StreamController.broadcast();
  Stream<List<AppNotification>> get onNotificationsChanged => _notificationsstreamController
      .stream; //hacemos su get, con Stream , puede ser escuchado de donde sea, esta es la escucha del stream controller de arriba jaja

  // constructor
  NotificationsController() {
    print("♠");
    //la escucha se la asignamos a nuestra variable subscription, el .listen regresa un streamSubscription por eso podemos asignarle el valor a subscription
    // estamos escuchando el stream de onNotification con .listen al Stream<AppNotification> emitido de StreamController<AppNotification>
    _subscription = _wsRepository.onNotification.listen(this._onNotificationListener);
  }

  //lo que estaria dentro del listen, ya q es su estructura
  void _onNotificationListener(AppNotification notification) {
    print("▲");
    _notifications = [notification, ...notifications]; //agregamos la notificacion al principio de la lista
    // _notifications.add(notification); //agragamos a la lista la notificacion no usado pk los agrega al final
    _notificationsstreamController.sink.add(_notifications); //agrgamos la lista al streamController
    notifyListeners(); //notificamos a las partes involucradas
  }

  //funcion para limpiar las notificaciones
  void clear() {
    _notifications = [];
  }

  @override
  void dispose() {
    print("notificationscontroller dispose");
    _notificationsstreamController.close(); //liberar recursos de este
    _subscription.cancel(); //para liberar la escucha
    super.dispose();
  }
}
