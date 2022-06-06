// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_import, prefer_const_constructors, prefer_const_declarations

import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// este 'widget' sera pa q nos muestre la suma del carrito actual :o
class CheckOutPreview extends StatelessWidget {
  const CheckOutPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyCartController>(); //para que escuche mycartcontroller
    if (!controller.hasItems) return Container(height: 0);
    //si no tiene items, entonces q no muestre el boton, ponerlo aca tambien y funcionara

    // movido al mycartcontroller
    //                 .map pa mapear | .reduce itera en cada valor de la lista, para que se sume nuestra lista
    // final subtotal = controller.cart.values.map((e) => e.price * e.counter).toList().reduce((value, element) => value + element);
    // final double iva = double.parse((subtotal * 0.10 + subtotal).toStringAsFixed(2)); //aqui podemos sumarle lo q queramos jeje
    // final double envio = 2.0;
    // final double total = double.parse((subtotal + iva + envio).toStringAsFixed(2));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15).copyWith(top: 30),
      decoration: BoxDecoration(
          color: primarycolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // nuevo widget, no usado antes
            Table(
              children: [
                //forma con metodo extraido
                _tablaItem("Subtotal", "\$${controller.subtotal}"),
                _tablaItem("Comision y IVA", "\$${controller.iva}"),
                _tablaItem("Envio", "\$${controller.envio}"),
                _tablaItem("Total", "\$${controller.total}"),
                // forma normal
                // TableRow(
                //   children: [
                //     Text("subtotal"),
                //     Text(
                //       "\$$subtotal",
                //       style: FontStyles.normal,
                //       textAlign: TextAlign.right,
                //     ),
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     Text("Comision"),
                //     Text(
                //       "\$$subtotal",
                //       style: FontStyles.normal,
                //       textAlign: TextAlign.right,
                //     ),
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     Text("Envio"),
                //     Text(
                //       "\$$subtotal",
                //       style: FontStyles.normal,
                //       textAlign: TextAlign.right,
                //     ),
                //   ],
                // ),
                // TableRow(
                //   children: [
                //     Text("total"),
                //     Text(
                //       "\$$subtotal",
                //       style: FontStyles.normal,
                //       textAlign: TextAlign.right,
                //     ),
                //   ],
                // )
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.deepOrange,
                  child: Text(
                    "Pagar",
                    style: FontStyles.titulo.copyWith(color: Colors.white),
                  ),
                  onPressed: () {}),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

//metodo extraido, como metodo  :O
  TableRow _tablaItem(String label, String value) {
    return TableRow(
      children: [
        Text(
          label,
          style: FontStyles.normal.copyWith(color: Colors.white),
        ),
        Text(
          value,
          style: FontStyles.titulo.copyWith(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
