import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/data/providers/remote/food_menu_prodiver.dart';

//interfaz
abstract class FoodMenuRepository {
  //las clases abstracta dentro solo tienen atributos y metodos sin cuerpo
  //esta clase se va a encargar de definir la estructuta de nuestro repositorio
  Future<List<Platillo>> getPopularMenu(); //get PopularMenu = getPopularMenu()
}

//implementacion
class FoodMenuRepositoryImpl implements FoodMenuRepository {
  final FoodMenuProvider _provider;

  FoodMenuRepositoryImpl(this._provider);
  @override
  Future<List<Platillo>> getPopularMenu() {
    return _provider.getPopularMenu(); //este es de food menu provider y asi obtenenmos los archivos del json
  }
}
