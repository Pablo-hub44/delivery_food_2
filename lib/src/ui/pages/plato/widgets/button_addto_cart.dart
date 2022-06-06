// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Builder(builder: (context) { ya no necesario ya q ocupamos el context del build
    //   return
    // });
    //resuperamos DishController pero no escuchamos los cambios listen false para que no se vuelva a renderizar de forma innecesaria este widget
    final dishcontroller = Provider.of<DishController>(context, listen: false);
    final bool isInCart = context.select<MyCartController, bool>((_) => _.isIncart(dishcontroller
        .dish)); //escuchar una propiedad en especifico de tipo MycartController de tipo bool, para saber si esta en el carrito o no
    return Padding(
      // context.watch<MyCartController>().isIncart(dish), //escuchar todo de mycartController, no ocupado
      padding: const EdgeInsets.only(bottom: 12),
      child: RoundedButton(
        label: isInCart ? 'Actualizar orden' : 'Agregar al carrito',
        onPressed: () {
          _addToCart(context);
        },
        fullWidth: false,
        fontSize: 18,
      ),
    );
  }

  //metodo pa agregar al carritow
  void _addToCart(BuildContext context) {
    // final HomeController homeController = Get.i.find<HomeController>(); //epico, antes, pk el metodo q queremos ya no esta ahi
    final MyCartController myCartController = context.read<MyCartController>(); //ahora usamosel estadoglobal echoen my_app cool

    final DishController controller = context.read<DishController>(); //.read pa recuperar nuestro dishController /escuche

    final isInCart = myCartController.isIncart(controller.dish); //recuperamos la funcion booleana pa saber si esta en el carrito

    myCartController.addToCart(controller.dish);

    final SnackBar snackBar = SnackBar(
      content: Text(
        isInCart ? "Orden Actualizada" : "Agregado al carrito",
      ),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar); //pa q aparesca el mensaje
  }
}
