// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DishHeader extends StatelessWidget {
  const DishHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 8, //AspectRatio widget para mantener las dimensiones entre diferentes dispositivos muy bueno
      child: Builder(
        //vamos a utilizar el contexto de este builder para acceder al dishController
        builder: (context) {
          final controler = Provider.of<DishController>(context);
          return Hero(
            // el widget hero para hacer animaciones, el widget del q viene y al q va, tienen q ser hero y tener el mismo tag, con eso le
            //da una animacion de transicion, lo recomendable es q su child sea el mismo widget :D
            tag: controler.tag, //"${controler.dish.id}",
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: controler.dish.image,
                    fit: BoxFit.cover, //para q la img no se distorcione
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.8),
                          Colors.white,
                        ],
                        // stops: [0.1, 0.2, 0.3, 1],
                      ),
                    ),
                  ),
                ),
                //seria el boton de regreso, positioned pa posicionar bien el boton
                Positioned(
                  left: 10,
                  top: 10,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(30),
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
