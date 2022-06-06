// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:delivery_food/src/data/modelos/category.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/home_tab_controller.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeTabController>(context, listen: false);
    //vamos a recuperar un dato de tipo HomeTabController, listes false para q no se vuelva a renderizar de forma innecesaria
    return Container(
      height: 150, //afuersas se tiene q poner las dimenciones para el ListView
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(controller.categorias.length, (index) {
          final category = controller.categorias[index]; //la pos index , referencia a los datos de la lista categorias
          return CategoryButton(
            category: category,
            isFirst: index == 0, //osease el primer elemento tendra un padding left de 17
          );
        }),
      ),
    );
  }
}

//widget propio, extraido aunque no era necesario extraerlo
class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.category,
    required this.isFirst,
  }) : super(key: key);

  final Category category;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isFirst ? 17 : 5, right: 10, bottom: 10, top: 5),
      child: CupertinoButton(
          //CupertinoButton el widget principal
          // color: Colors.white,
          // padding: EdgeInsets.all(10),
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0), //borde redondeadito
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)), //la sombrita
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Expanded(
                    child: SvgPicture.asset(
                      category.iconPath, //antes 'assets/pages/home/home_tab/breakfast.svg',
                      width: 90,
                      // height: 90, //sevisar si quitarlo o no
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    category.label, //antes 'Breakfast',
                    style: FontStyles.normalnegrito.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {}),
    );
  }
}
