// ignore_for_file: unnecessary_this, implementation_imports, unnecessary_brace_in_string_interps, avoid_print

import 'dart:async';

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/data/repositorios/websocket_repository.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

// import 'widgets/home_button_bar.dart';

class HomeController extends ChangeNotifier implements TickerProvider {
  final NotificationsController notificationsController; //traemos este controlador, q es un global controller MultiProvider

  // TabController tabController = TabController(length: 4, vsync: NavigatorState()); //asi ya no :,v por el estupido sdk actualizado
  //necesario para el tabBar y tabbarView, antes se ponia DefaultController pero no usado, es clase de dart, grcias a esto podrmos movernos entre tabs
  //cambiado asi
  HomeController(this.notificationsController) {
    _init();
  }
  // propiedades
  // la lista de instancias de los botones | menuItems
  List<BottomBarItem> _items = [
    BottomBarItem(icon: 'assets/pages/home/home.svg', label: 'Home'),
    BottomBarItem(icon: 'assets/pages/home/favorite.svg', label: 'Favoritos'),
    BottomBarItem(icon: 'assets/pages/home/bell.svg', label: 'Notificaciones'), //[2]
    BottomBarItem(icon: 'assets/pages/home/avatar.svg', label: 'Perfil'),
  ];
  List<BottomBarItem> get items => _items; //como es un dato privado, lo traemos con get

  // treamos nuestro websocketrepository para poner el connect
  final _wsRepository = Get.i.find<WebsocketRepository>(lazy: true); //update le agregamos el lazy, por lizyput

  @visibleForTesting //solo pa propeiedades publicas, pa q nos aparesca un msg si lo ponemos en page q solo se usa pa test
  bool disposed = false; //usado para testear

  int _actualPagina = 0;

  int get actualPage => _actualPagina; //con get ya q era una variable privada

  // List<Platillo> _favoritos = [];antes
  // List<Platillo> get favoritos => _favoritos; //el get pa usar la variable privada

  Map<int, Platillo> _favoritos = {}; //convertido a map para usar sus id
  Map<int, Platillo> get favoritos => _favoritos; //el get pa usar la variable privada

  // Map<int, Platillo> _cart = {}; //donde se va a guardar los favs agregados al carrito
  // Map<int, Platillo> get cart => _cart;  movido a my_cart_controller

  bool isFavorite(Platillo dish) =>
      _favoritos.containsKey(dish.id); //de esta manera sabremos si el platillo esta en el map de favoritos

  void Function()? onDisposee;

  late TabController tabController; //late, q la propiedad no es nula y se declarara despues
  void _init() async {
    tabController = TabController(length: 4, vsync: this);
  }

  StreamSubscription? _notificationsSubscription; //propiedad donde se guardara la subscriptio

//como el initState//esta escuchando los cambios
  void afterFirstLayout() {
    //llamamos a conect aqui es la mejor opcion, ya se estaria logueado pk esto se ejecuta en el home, | dentro se pondria la url del socket, asi simulamos la conexion
    _wsRepository.connect("https://websocket.com"); //con esta llamada inicia el init de WebsocketRepository

    //escuchamos nuestro stream de notificationcontroller de <List<AppNotification>>
    _notificationsSubscription = this.notificationsController.onNotificationsChanged.listen((notifications) {
      final int count = notifications.length;
      print("count :${count}");
      List<BottomBarItem> copy = [..._items]; //hacemos una copia de la lista y se la asignamos a copy, solo es una copia
      copy[2] = copy[2].copyWith(
        badgeCount: count, //el count de las notifications q estamos escuchando, se lo ponemos a baggecount, de qesta en pos 2
      );
      // print("count :${si.badgeCount}");
      _items = copy; //le asignamos la copia modificada de lo de arriba, a la lista original
      // osease modificamos la lista original
      notifyListeners();
    });
    this.tabController.addListener(() {
      //setPage(this.tabController.index); //The index of the tab actualmente seleccionado
      _actualPagina = tabController.index;
      notifyListeners(); //para q ambas partes sean notificadas
    });
  }

  // //metodo asignarpagina ya no ocupado pk se modifico a mejor el homebuttonbar con tabController
  // void setPage(int page) {
  //   // print("emojiji");
  //   _actualPagina = page;
  //   this.tabController.index = page; //para cuando hagamos tap en los botones valla a la pagina
  //   notifyListeners(); //pa q escuche los cambios y cambie dependiento cual sea la actualPagina
  // }

//metodo para agregar favoritos, el dish lo agregaremos el map
  void addFavorites(Platillo dish) {
    //vamos a crear una copia de la lista y le vamos a agregar unos elementos y nuestra lista de favoritos sea igual a la copia
    //y de ese modo notifilisteners va a detectar q tenemos un a nueva lista, y asi funciona notifylisterner para Listas
    Map<int, Platillo> copyMap =
        Map<int, Platillo>.from(_favoritos); // List<Platillo> copyList = List<Platillo>.from(_favoritos);

    if (_favoritos.containsKey(dish.id)) {
      //si favoritos contiene a nuestro platillo, que lo borre, esta para que no se muestren duplicados
      copyMap.remove(dish.id);
    } else {
      copyMap[dish.id] = dish; //copyList.add(dish); //si no esta, entonces que lo agrege, struct paq lo agrege: copyMap[dish.id]
    }
    _favoritos = copyMap; //la copia se la ponemos a favoritos al map original
    notifyListeners(); //notificamos a las partes involucradas :D
  }

  //metodo para borrar favoritos
  void deleteFavorite(Platillo dish) {
    //vamos a crear una copia de la lista y le vamos a agregar unos elementos y nuestra lista de favoritos sea igual a la copia
    //y de ese modo notifilisteners va a detectar q tenemos una nueva lista, y asi funciona notifylisterner para Listas
    Map<int, Platillo> copyMap =
        Map<int, Platillo>.from(_favoritos); // List<Platillo> copyList = List<Platillo>.from(_favoritos);

    if (_favoritos.containsKey(dish.id)) {
      //si favoritos contiene a nuestro platillo, que lo borre, esta para que no se muestren duplicados
      copyMap.remove(dish.id);
      _favoritos = copyMap; //la copia se la ponemos a favoritos
      notifyListeners(); //notificamos a las partes involucradas :D
    }
  }

// --movido a my_cart_controller
  // void addToCart(Platillo dish) {
  //   Map<int, Platillo> copyMap = Map<int, Platillo>.from(_cart); //una copia del carrito
  //   copyMap[dish.id] = dish; //si el producto ya existia, simplemente se reemplaza
  //   _cart = copyMap; //ahora _cart sera igual a la nueva copia
  //   notifyListeners(); //notificamos a las partes involucradas :D
  // }

  // // metodo para borrar algo de nuestro carrito
  // void deleteFromCart(Platillo dish) {
  //   Map<int, Platillo> copyMap = Map<int, Platillo>.from(_cart);

  //   if (copyMap.containsKey(dish.id)) {
  //     //si el platillo esta en el carrito(por su id) lo borrara
  //     copyMap.remove(dish.id);
  //     _cart = copyMap; //la copia se la ponemos a _cart
  //     notifyListeners(); //notificamos a las partes involucradas :D
  //   }
  // }
  // --

  //metodo,  gracias a chageNotifier podemos sobreescribir dispose
  @override
  Future<void> dispose() async {
    await this._notificationsSubscription?.cancel(); //cancela la subscripcion
    this.tabController.dispose(); //liberar los recursos del tabcontroller
    // si ondisposee no es nulo q llame a tal funcion q es un callback, podemos poner ahi cualquier funcion
    if (this.onDisposee != null) {
      this.onDisposee!();
    }
    // await _wsRepository.disconnect();
    disposed = true;
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

//nuestra clase pa los botoncitos del bar
class BottomBarItem {
  final String icon, label;
  final int badgeCount; // pa el numero de notificaciones que hay

  // constructor
  BottomBarItem({required this.icon, required this.label, this.badgeCount = 0});

  // hacemos una copia para luego modicarla como queramos , q retorna una instancia dela misma clase
  BottomBarItem copyWith({String? icon, String? label, int? badgeCount}) {
    return BottomBarItem(icon: icon ?? this.icon, label: label ?? this.label, badgeCount: badgeCount ?? this.badgeCount);
    // null condition ??,  sino es nulo tomalo ?? sino, toma este
  }
}
