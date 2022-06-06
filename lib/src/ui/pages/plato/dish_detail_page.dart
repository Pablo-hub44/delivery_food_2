// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print, sized_box_for_whitespace, unused_element

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/global_widgets/svg_from_asset.dart';
// import 'package:delivery_food/src/ui/global_controllers/my_cart_controller.dart';
// import 'package:delivery_food/src/ui/global_widgets/rounded_button.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_controller.dart';
import 'package:delivery_food/src/ui/pages/plato/widgets/button_addto_cart.dart';
import 'package:delivery_food/src/ui/global_widgets/dish_counter.dart';
import 'package:delivery_food/src/ui/pages/plato/widgets/dish_header.dart';
import 'package:delivery_food/src/utils/colors.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DishDetailPage extends StatelessWidget {
  const DishDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DishController>(
      create: (_) {
        //la inyeccion de homecontroller
        final homeController = Get.i.find<HomeController>();

        //ModalRoute.of(context).settings.arguments duda de funcionamiento, necesita el contexto de build para leer el argumento
        // final Platillo dish = ModalRoute.of(context).settings.arguments; //esta escuchando los argumentos enviados en el nav :O | antes
        final DishpageArguments argumentos =
            ModalRoute.of(context)!.settings.arguments as DishpageArguments; //asqesecomportecomo DishpageArguments
        print("${argumentos.tag}");

        final isFavorite = homeController.isFavorite(argumentos.dish); //inicializzamos isfav con el isfav que tenemos en homeCon
        final controllerr = DishController(argumentos, isFavorite);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light); //con esta cambiamos el el color de los icons superiores
        //aqui escuchamos q nuestro changeNotifierprov es destruido
        controllerr.onDispose = () {
          // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          return _setStatusBar(false); //lo pondra en negro
        };
        return controllerr;
      },
      child: Scaffold(
        // appBar: AppBar(),
        //botoncito| envuelto en un builder para q tenga context y asi comunicar con el create
        floatingActionButton: AddToCartButton(),
        // Builder(builder: (context) { ya no ocupado, movido a button_addto_cart.dart
        //   return Padding(
        //     context.watch<MyCartController>().isIncart(dish), //eschucar todo de mycartController
        //     padding: const EdgeInsets.only(bottom: 12),
        //     child: RoundedButton(
        //       label: 'Agregar al carrito',
        //       onPressed: () {
        //         _addToCart(context);
        //       },
        //       fullWidth: false,
        //       fontSize: 18,
        //     ),
        //   );
        // }),
        //la localizacion de donde estara en botoncito
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DishHeader(),
                Builder(builder: (_) {
                  //la inyeccion de la dependencia - gracias a esto  podemos acceder a metodos de otro controller :O
                  // ignore: unused_local_variable
                  // final homeController = Get.i.find<HomeController>();

                  final controller = Provider.of<DishController>(_); //oir el contexto del changenotifier
                  final dish = controller.dish;
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, //<->
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //expanded pa evitar el error de overfloww
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, //<->
                                children: [
                                  Text(
                                    dish.name,
                                    style: FontStyles.titulo,
                                  ),
                                  Text(
                                    "\$ ${dish.price}",
                                    style: FontStyles.normal.copyWith(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            CupertinoButton(
                              // le damos una key pa poder testearlo
                              key: Key('favoritoov'),
                              padding: EdgeInsets.all(10),
                              // child: SvgFromAsset(path: path, width: ,height: ,color: ,), no usado
                              child: SvgPicture.asset(
                                'assets/pages/home/favorite.svg',
                                width: 35,
                                height: 35,
                                color: controller.isFavorite ? primarycolor : Colors.grey,
                              ),
                              onPressed: () {
                                _toggleFavorite(_); //el contexto del builder
                                // Provider.of<HomeController>(context);
                                //la inyeccion de la dependencia - gracias a esto podemos acceder a metodos de otro controller :O
                                // * puesto en el builder jeje, update: todo esto ya esta dentro de _toggleFavorite
                                // controller.toggleFavorite(); //este viene del controler propio
                                // homeController.addFavorites(dish); //este no :D
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        DishCounter(
                          initialValue: controller.dish.counter, //el contador si tiene con su valor guardado en counter
                          onChanged: controller.onCounterChanged,
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          dish.description,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setStatusBar(bool light) {
    SystemChrome.setSystemUIOverlayStyle(light ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  }

  //funcion pa que muestre un mensaje si, es que no esta agregado a favoritos (esta cool)
  void _toggleFavorite(BuildContext context) {
    print("_toggleFavorite");
    final homeController = Get.i.find<HomeController>();
    final controller = context.read<DishController>();

    //sino se encuentra en favoritos que aparesca un mensaje
    if (!controller.isFavorite) {
      final SnackBar snackBar = SnackBar(
        content: Text("Agregado a favoritos"),
        backgroundColor: primarycolor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    controller.toggleFavorite(); //llamamos al toogle del controller
    homeController.addFavorites(controller.dish); //se agregara al mapa de _favorites
  }
}
// -----
