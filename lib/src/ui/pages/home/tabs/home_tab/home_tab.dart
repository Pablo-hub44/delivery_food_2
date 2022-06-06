// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/home_tab_controller.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/widgets/categorias_menu.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/widgets/horizontal_dishes.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/widgets/search_button.dart';
import 'package:delivery_food/src/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

// AutomaticKeepAliveClientMixin nos ayudara a preservar el estado de nuestra pagina, osease el scroll de donde se quedó
//y eso se tendria q poner en cada pestaña en la q querramos preservar el estado
class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); //llamar antes del return a esto, para q funcione keepAlive y le pasamos el contexto
    print("home");
    // return ListView.builder(
    //   itemBuilder: (BuildContext context, index) => Text("$index"),
    //   itemCount: 20,
    // );
    return ChangeNotifierProvider<HomeTabController>(
      create: (context) {
        final controller = HomeTabController();
        //con esto hara que nuestra pagina renderize sin problema, que tome su tiempo
        WidgetsBinding.instance!.addPostFrameCallback((context) {
          controller.afterFirstLayout();
        });
        return controller;
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //alinear a la izq.
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //<->
                  children: [
                    Text("Bienvenido Jose"),
                    const SizedBox(height: 10),
                    Text(
                      "As tu propia comida, quedate en casa",
                      style: FontStyles.titulo.copyWith(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    SearchButton(), //widget propio :D
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              CategoriesMenu(), //widget propio
              const SizedBox(height: 20),
              Builder(builder: (context) {
                final List<Platillo> popularMenu = context.select<HomeTabController, List<Platillo>>((value) => value
                    .popularMenu); //que oiga los cambios dee lq propiedad popularMenu q esta en el homeTabController de ahi va a sacar la info
                return HorizontalDishes(
                  dishes: popularMenu,
                  title: 'Popular menu',
                  onpressed: () {},
                  // tag: 'popular-menu',
                );
              }),
              const SizedBox(height: 20),
              Builder(builder: (context) {
                final List<Platillo> popularMenu = context.select<HomeTabController, List<Platillo>>((value) =>
                    value.popularMenu); //que oiga los cambios dee lq propiedad popularMenu q esta en el homeTabController
                return HorizontalDishes(
                  dishes: popularMenu,
                  title: 'Menus especiales',
                  onpressed: () {},
                  // tag: 'menu-especial',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  //con esto vamos a preservar el estado aqui en el hometab del TabBarView del home_page tiene q ser true
}
