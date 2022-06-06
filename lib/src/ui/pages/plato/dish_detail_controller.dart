// ignore_for_file: unnecessary_this

import 'package:delivery_food/src/data/modelos/platillo.dart';
// import 'package:delivery_food/src/helpers/get.dart';
// import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:flutter/cupertino.dart';

class DishController extends ChangeNotifier {
  Platillo dish; //sera el platillo donde haga click
  final String tag;
  // get dish => _dish; //no usado
  VoidCallback? onDispose;

  // DishController({ antess
  //   @required this.dish,
  //   @required this.tag,
  // });
  //: para poder inicializar nuestras propiedades final en el cuerpo del constructor es con :  :O
  DishController(DishpageArguments arguments, this._isFavorite)
      : this.dish = arguments.dish,
        this.tag = arguments.tag;
  // this.isFavorite = Get.i.find<HomeController>().isFavorite(arguments.dish); //asi inicializamos la propiedad isFavorite , ay otra manera

  // ----

  @override
  void dispose() {
    if (onDispose != null) {
      onDispose!();
    }
    super.dispose();
  }

  // int _counter = 0; ya no usado +
  // int get counter => _counter; //retornamos nuestro valor privado para poder ocuparlo , ya no usado +
  bool _isFavorite; //pa q escuche aca como en en homecontroller, pero no sea modificada pk en privada
  bool get isFavorite => _isFavorite;

  //metodo para guardar el contador
  void onCounterChanged(int counter) {
    // _counter = counter; ya no usado + , ya q ahora se usara el counter creado en el modelo de Platillo
    this.dish = this.dish.updatecounter(counter);
    //de esta manera el metodo updateCounter de la clase dish, va a retornarnos una copia con el contador actualizado
  }

  //metodo de favorite pa q cuando se presione se cambie por su contrario
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners(); //pa q escuche los cambios
  }
}

// ------
// clase necesaria para que funcione el tag , hero etc

class DishpageArguments {
  final Platillo dish; //sera el platillo donde haga click
  final String tag;

  DishpageArguments({
    required this.dish,
    required this.tag,
  });

  // ---

}
