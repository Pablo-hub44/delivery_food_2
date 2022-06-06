// ignore_for_file: unnecessary_this

import 'package:delivery_food/src/data/modelos/notification.dart';
import 'package:delivery_food/src/data/providers/remote/websocket_provider.dart';

abstract class WebsocketRepository {
  // propiedades
  Future<void> connect(String uri);
  Future<void> disconnect();

  Stream<AppNotification> get onNotification; //un get con Stream pa q podamos escuchar
}

//
//
//
//
// la implementacion, donde se reescribiran los metodos que pusimos en la clase abstracta
class WebsocketRepositoryImpl implements WebsocketRepository {
  final WebsocketProvider _provider; //de nuestro provider remote, lo traemos

  WebsocketRepositoryImpl(this._provider);
  @override
  // el metodo de connect reescrito
  Future<void> connect(String uri) {
    return _provider.connect(uri); //llamamos al metodo y le pasamos la uri , del metodo de aca connect
  }

  @override
  Stream<AppNotification> get onNotification => _provider.onNotification;

  @override
  Future<void> disconnect() {
    return _provider.disconnect(); //q desconecte
  }
}
