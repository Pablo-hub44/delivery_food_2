// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
// import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //escuchar una propiedad hasitems de  mycartcontroller controlador global
    final bool hasItems = context.select<MyCartController, bool>((_) => _.hasItems);

    if (!hasItems) return Container(); //si no tiene items, entonces q no muestre el boton

    // .select pa el tipo de dato que vamos a escuchar,<de donde, el tipo de dato>
    final cart = context.select<MyCartController, Map<int, Platillo>>((_) => _.cart);
    return Stack(
      children: [
        FloatingActionButton(
          backgroundColor: primarycolor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.Carrito);
          },
          // SvgFromAsset(path: path, color:, width:,), no usado
          child: SvgPicture.asset(
            'assets/pages/home/cart.svg',
            width: 30,
            color: Colors.white,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: Colors.deepOrange, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              "${cart.length}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
