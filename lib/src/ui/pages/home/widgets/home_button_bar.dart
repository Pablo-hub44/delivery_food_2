// ignore_for_file: unnecessary_this, implementation_imports, avoid_unnecessary_containers, prefer_const_constructors

import 'package:badges/badges.dart';
// import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/home_indicator.dart';
import 'package:delivery_food/src/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

class HomeButtonBar extends StatelessWidget {
  const HomeButtonBar({Key? key}) : super(key: key);
  //todo esto puede ser reutilizable date cuenta de la lista, el listgenerate y el homecontroller
  //la lista de los botones | menuItems, movido pk aqui se queda estatico, y si lo movemos al home_controller, con changeNotifier puede se dinamico
  // List<BottomBarItem> _items = [
  //   BottomBarItem(icon: 'assets/pages/home/home.svg', label: 'Home'),
  //   BottomBarItem(icon: 'assets/pages/home/favorite.svg', label: 'Favoritos'),
  //   BottomBarItem(icon: 'assets/pages/home/bell.svg', label: 'Notificaciones'), //[2]
  //   BottomBarItem(icon: 'assets/pages/home/avatar.svg', label: 'Perfil'),
  // ];

  // List<BottomBarItem> get items => _items; //como es un dato privado, lo traemos con get

  // //set es para definir un parametro y tiene que ser del mismo tipo del q queremos modificar :O
  // set itemsSet(List<BottomBarItem> items) {
  //   //solo puede tener un parametro
  //   _items = items;
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false); //escuche de home controller q retornamos encreate()
    //select para recuperar el dato de homeController de tipo int, escuchar los cambios de actualPage
    final int actualPage = context.select<HomeController, int>((valor) => valor.actualPage);

    final itemss = context.select<HomeController, List<BottomBarItem>>(
        (valor) => valor.items); //escuchamos la propiedad items de homecontroller y tipo List<bottombaritem>

    return Container(
      child: SafeArea(
        top: false,
        // nuestro propio tabbar , q se conecta con el tabbarview y el tabbarcontroller
        child: TabBar(
          controller: controller.tabController, //nuestro tabcontroller pa el tabar, este <-
          indicator: HomeTabBarIndicator(color: primarycolor, size: 6),
          tabs: List.generate(itemss.length, (index) {
            final item = itemss[index]; //hacemos referencia a las propiedades de nuestra lista
            return BotonBarra(
              isActive: actualPage == index,
              item: item,
            );
          }),
        ),
      ),
    );
  }
}

//widget de nuestros botoncitos
class BotonBarra extends StatelessWidget {
  //variables q pasaremos por parametro
  final BottomBarItem item;
  final bool isActive; //defecto es verdadero
  //final VoidCallback onPressed; //funcion q no retorne nada y tampoco tiene un parametro ya no necesaria ya q ocupamos el controller del tabBar -

  //constructor
  const BotonBarra({
    Key? key,
    required this.item,
    required this.isActive,
    // @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // toda la estructura, almacenada en content
    final content = Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 8),
      child: Column(
        children: [
          // SvgFromAsset(path: path), no usado
          SvgPicture.asset(
            item.icon,
            width: 25,
            height: 25,
            color: isActive ? primarycolor : Colors.black, //si es verdadero entonces primaycolor
          ),
          Text(
            item.label,
            maxLines: 1, //maximo de lineas q tendra el texto
            overflow: TextOverflow.ellipsis, //pone ... si el text ocupa mas de una linea
            style: TextStyle(
              fontSize: 8,
              color: isActive ? primarycolor : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    return Tab(
      key: Key(item.label), //ponemos una key pa testear
      // badge dependencia externa pa agregarle el iconito de notificaciones
      icon: item.badgeCount > 0 //si el contador es mayor a 0 q muestre el bagde y content normal
          ? Badge(
              animationType: BadgeAnimationType.scale, //el tipo de animacion
              badgeContent: Text(
                "${item.badgeCount}",
                style: TextStyle(color: Colors.white),
              ),
              child: content)
          : content, //sino, solo el content
    );

    //   return Expanded( antess
    //     child: CupertinoButton(
    //       padding: const EdgeInsets.symmetric(vertical: 10),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    // SvgPicture.asset(
    //     item.icon,
    //     width: 25,
    //     color: isActive ? primarycolor : Colors.black, //si es verdadero entonces primaycolor
    //   );
    //           Text(
    //             item.label,
    //             maxLines: 1, //maximo de lineas q tendra el texto
    //             overflow: TextOverflow.ellipsis, //pone ... si el text ocupa mas de una linea
    //             style: TextStyle(
    //               color: isActive ? primarycolor : Colors.black,
    //             ),
    //           )
    //         ],
    //       ),
    //       onPressed: this.onPressed,
    //     ),
    //   );
    // }
  }
}

// movido  a home controller
// //nuestra clase pa los botoncitos del bar
// class _BottomBarItem {
//   final String icon, label;
//   final int badgeCount; // pa el numero no notificaciones que hay

//   _BottomBarItem({required this.icon, required this.label, this.badgeCount = 0});
// }
