// ignore_for_file: prefer_const_constructors, prefer_is_empty

// import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/ui/pages/carrito/widgets/carrito_item.dart';
import 'package:delivery_food/src/ui/pages/carrito/widgets/check_out_preview.dart';
// import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final cart = Get.i.find<HomeController>().cart.values.toList(); //traer el cart que está hasta homeController, antes,
    final cart = context.watch<MyCartController>().cart.values.toList(); // ahora usamos el estado global echo en my_app

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Mi carrito"),
        elevation: 0,
        // backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      body: SafeArea(
        //pa generar nuestra lista de vistas  con los datos de cart
        child: cart.length == 0
            ? Center(child: Text("No hay elementos")) //con operadores ternacios para q si el carrito esta vacio mueste esto
            : ListView.builder(
                itemBuilder: (_, index) {
                  final dish = cart[index]; //cart en la pos index, almacenado en dish
                  return CarritoItem(dish: dish);
                },
                itemCount: cart.length, //q seae la cantidad que elementos q tenemos en el cart
              ),
      ),
      bottomNavigationBar: CheckOutPreview(),
    );
  }
}
