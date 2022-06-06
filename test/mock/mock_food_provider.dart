// al no tener esto en el homepagetest da este error
// assertion failed: "tag FoodMenuRepository no encontrada, asegurate de llamar primero al put"

// para reescribir los metodos y ocuparlo para testear
import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/data/providers/remote/food_menu_prodiver.dart';

class MockFoodMenuProvider implements FoodMenuProvider {
  @override
  Future<List<Platillo>> getPopularMenu() async {
    Future.delayed(const Duration(milliseconds: 300));
    return [
      // pasaremos un platillo
      Platillo(
        id: 1,
        name: "",
        price: 59.50,
        rate: null,
        image: "",
        description: "",
      ),
    ];
  }
}
