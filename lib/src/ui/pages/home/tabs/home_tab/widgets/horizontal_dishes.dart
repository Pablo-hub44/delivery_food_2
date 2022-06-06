// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_this, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalDishes extends StatelessWidget {
  //nuestras propiedades
  final List<Platillo> dishes;
  final String title;
  final VoidCallback? onpressed;
  // final String tag; //pa ponerle un tag diferente a cada horizontaldish ya no usado pk ocupamos la key

  const HorizontalDishes({
    Key? key,
    required this.dishes,
    required this.title,
    this.onpressed,
    // @required this.tag,
  }) : //assert(dishes != null), //validamos que dishes no sea puesto como nulo y q tenga al menos un elemento
        //assert(dishes.length > 0), inicialmente es vacia y va llenandose compilando por eso mejor quitarlo
        //assert(title != null), //title no pueda ser nulo
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // final widthh = MediaQuery.of(context).size.width * 0.6; //con esto obtenemos las dimensiones, el ancho de la pantalla el 60% | ya no ocupado pk le pusimos un AspectRatio
    return Container(
      height: 200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), //padding a los lados :D
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: FontStyles.titulo),
                CupertinoButton(
                  minSize: 25,
                  // color: primarycolor,
                  padding: EdgeInsets.all(10),
                  child: Text("Ver todo", style: FontStyles.normalnegrito),
                  onPressed: this.onpressed,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                final item = dishes[index]; //los items de la lista platos
                return DishHomeItem(
                  key:
                      UniqueKey(), //flutter le asigna un key unico a cada uno de los elementos de la listaHorintal, con esto le asigna un tag unico
                  item: item,
                  isFirst: index == 0, //si cumple esto sera verdadero
                  // tag: this.tag,
                );
              },
              itemCount: dishes.length,
            ),
          ),
        ],
      ),
    );
  }
}

//widget propio AspectRatio extraido, pa q no este todo como un revoltijo, pa cada item de los platillos xd
class DishHomeItem extends StatelessWidget {
  // final String tag; //pa ponerle un tag diferente a cada horizontaldish || ya no usado pk usamos la key
  final Platillo item;
  final bool isFirst;

  const DishHomeItem({
    Key? key,
    required this.item,
    required this.isFirst,
    // @required this.tag,
  }) : //assert(item != null), //validamos que item no sea puesto como nulo
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, //AspectRatio widget para mantener las dimensiones entre diferentes dispositivos muy bueno
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10).copyWith(left: isFirst ? 15 : 10), //antes (left: isFirst == 0 ? 15 : 10),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _gotoDetail(context);
          },
          child: Stack(
            children: [
              Hero(
                //su pareja esta en dish_header
                tag:
                    "${this.key.toString()}-${item.id}", //el id del item, del modelo Platillo :D, antes agregado tambien "${this.tag}-
                child: ClipRRect(
                  // ClipRRect para redondear la imgs y mas
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    // width: widthh,
                    width: double.infinity,
                    fit: BoxFit.cover, //para no distorcionar la img
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ), //dependencia externa, pa las fotos de internet
              Positioned(
                left: 0,
                right: 0,
                bottom: -1,
                child: Container(
                  padding: EdgeInsets.all(10).copyWith(top: 50),
                  decoration: BoxDecoration(
                    //darle un color dregradado
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.9),
                        Colors.white,
                      ],
                      stops: [0.1, 0.2, 0.3, 0.5, 1],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //<->
                    children: [
                      Text(
                        item.name,
                        style: FontStyles.normal.copyWith(fontSize: 20, color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, //lo repara los mas q pueda
                        children: [
                          // Text("\$${item.price}"), antes ||  RichText pa cambiarle el tamaño a algo sin q afecte a los demas :O
                          RichText(
                            text: TextSpan(
                              text: "\$",
                              style: FontStyles.normalnegrito
                                  .copyWith(color: primarycolor, fontSize: 12.0, fontStyle: FontStyle.italic),
                              children: [
                                TextSpan(text: " ${item.price}", style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal)),
                              ],
                            ),
                          ),
                          if (item.rate != null) //asi hacemos q muestre el rate solo si existe
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                color: primarycolor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "${item.rate}",
                                    style: FontStyles.normal.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _gotoDetail(BuildContext context) {
    final int counter = context.read<MyCartController>().getDishCounter(this.item); //q traiga el contador actual de dish

    final Platillo dish = item.updatecounter(counter); //el metodo del modelo updatecounter lo ponemos en dish
    Navigator.pushNamed(
      context, Routes.Dish, //va a dish_detail
      // arguments: {"dish": this.item, "tag": "${this.tag}-${item.id}"}); //arguments: this.item con eso
      //le estamos enviando tambien los argumentos de item y asi puede mostrar tal dato como la imagen
      arguments:
          DishpageArguments(dish: dish, tag: "${this.key.toString()}-${item.id}"), //antes agregado tambien tag:"${this.tag}-${}
      //                en la tag le pasamos la key unica y el id del platillo
      //le pasamos todo esto por argumento y va a dishDetailPage
      // antes dish: this.item
    );
  }
}
