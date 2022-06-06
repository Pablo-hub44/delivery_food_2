// ignore_for_file: unnecessary_overrides

import 'package:delivery_food/src/data/modelos/category.dart';
import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/data/repositorios/food_menu_repo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter/cupertino.dart';

class HomeTabController extends ChangeNotifier {
  //nuestra dependencia  inyectada
  // final FoodMenuRepositoryImpl foodMenuRepository = FoodMenuRepositoryImpl(FoodMenuProvider()); manera basica
  final FoodMenuRepository _foodMenuRepository = Get.i.find<FoodMenuRepository>(); //.find llamamos a la dependencia q necesitamos

  //definimos los items del menu horizontal Categoria
  final List<Category> categorias = [
    Category(iconPath: "assets/pages/home/home_tab/breakfast.svg", label: "Breakfast"),
    Category(iconPath: "assets/pages/home/home_tab/fries.svg", label: "Fast food"),
    Category(iconPath: "assets/pages/home/home_tab/dinner.svg", label: "Dinner"),
    Category(iconPath: "assets/pages/home/home_tab/dessert.svg", label: "Desserts"),
  ];

  List<Platillo> _popularMenu = [];
  List<Platillo> get popularMenu => _popularMenu;

  //como el initState//esta escuchando los cambios, se ejecutara una sola vez cuando hometab sea renderizado
  void afterFirstLayout() {
    _init();
  }

  void _init() async {
    // _popularMenu sea igual a la lista de platillos retornada por foodmenurepository.get
    _popularMenu = await _foodMenuRepository.getPopularMenu();
    notifyListeners(); //para notificar a las partes involucradas //NO SE TE OLVIDE PONERLO
  }

  //metodo,  gracias a chageNotifier podemos sobreescribir dispose
  @override
  void dispose() {
    //liberar los recursos
    super.dispose();
  }
}
