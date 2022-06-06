// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteItem extends StatelessWidget {
  //propiedades
  final Platillo dish;
  const FavoriteItem({
    Key? key,
    required this.dish,
  }) : //assert(dish != null), // validamos que dish no pueda ser nulo
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Slidable widget externo pa botones en los lados de nuestros favs items :0
    return Slidable(
      // endActionPane: ActionPane( v.ultima slidable pero no funciona
      //   motion: ScrollMotion(),
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 5, left: 0),
      //       child: SlidableAction(
      //         onPressed: (context) {
      //           _deleteItem(context);
      //         },
      //         backgroundColor: Colors.red,
      //         label: 'Borrar',
      //         icon: Icons.delete,
      //       ),
      //     ),
      //   ],
      // ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).copyWith(bottom: 5, left: 0),
          child: IconSlideAction(
            caption: 'Borrar',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _deleteItem(context);
            },
          ),
        ),
      ],
      child: Container(
        margin: EdgeInsets.all(10).copyWith(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                // para redondear la imagen
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: dish.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //<->
                children: [
                  Text(
                    dish.name,
                    style: FontStyles.normal,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(color: primarycolor, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${dish.rate}",
                          style: FontStyles.normal.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //funcion para borrar un item de favoritos, funcion q manda a llamar a otra funcion jeje,, no necesario el buildcontext
  void _deleteItem(BuildContext context) {
    //traemos homeController a aca
    final homecontroller = Get.i.find<HomeController>();
    homecontroller.deleteFavorite(dish);
  }
}
