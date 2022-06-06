// ignore_for_file: prefer_const_constructors

import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/fav_tab/favorites_tab.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/home_tab/home_tab.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/notifications_tab/noficications_tab.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/profile_tab/profile_tab.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/my_cart_button.dart';
import 'package:delivery_food/src/ui/pages/home/widgets/home_button_bar.dart';
// import 'package:delivery_food/src/ui/pages/home/widgets/home_indicator.dart';
// import 'package:delivery_food/src/utils/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //antess class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // //como extiende de state podemos ocupar este mixin TickerProviderStateMixin
  // TabController tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(length: 5, vsync: this);
  // }

  // @override
  // void dispose() {
  //   //liberar los recursos del tabcontroller
  //   tabController?.dispose(); //? si tanbien fuera nulo
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // ocupamos el multiprovider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotificationsController>(
          create: (_) => NotificationsController(),
        ),
        // antews solo estaba este, pero ahora en multi
      ],
      builder: (context, __) {
        return ChangeNotifierProvider<HomeController>(
          create: (_) {
            final controller =
                HomeController(context.read<NotificationsController>()); //ponemos  esto ya q se lo pusmios como parametro
            //con esto hara que nuestra pagina renderize sin problema, que tome su tiempo, y q renderize al menos una ves
            WidgetsBinding.instance!.addPostFrameCallback((context) {
              controller.afterFirstLayout(); //con esta llamada inicia las notificaciones :D
            });

            //inyecion de dependencia para comunicar este controller y llevarlo a otro lado a dishPage
            Get.i.put<HomeController>(controller); //put para guardar
            controller.onDisposee = () => Get.i.remove<HomeController>(); //para liberar el recurso
            return controller;
          },
          builder: (context, __) {
            final controller = Provider.of<HomeController>(context, listen: false); //le pasamos el context del create
            //q regrese el homeController, y listen false para q no se vuelva a renderizar de forma innecesaria todo el scaffold
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: HomeButtonBar(), //widget propio, dara la estructura de la navegacion
              //el boton del carrito :O
              floatingActionButton: FloatingCartButton(), //widget propio, :D extraido pa q no se acumule to aqui
              // appBar: AppBar(
              //   title: Text("Home", style: TextStyle(color: Colors.black)),
              //   backgroundColor: Colors.white,
              //   elevation: 0,
              //   bottom: TabBar(
              //     controller: controller.tabController,
              //     indicatorColor: primarycolor, //cambia el colorsito indicador
              //     indicatorWeight: 3,
              //     indicator: HomeTabBarIndicator(
              //       //HomeTabBarIndicator widget nuestro
              //       size: 8,
              //       color: primarycolor,
              //     ),
              //     // BoxDecoration( antes
              //     //   color: Colors.white,
              //     //   shape: BoxShape.circle,
              //     //   border: Border.all(width: 1, color: primarycolor),
              //     // ),
              //     labelColor: primarycolor,
              //     // isScrollable: true,
              //     unselectedLabelColor: Colors.black38, //pa los iconos q no estan seleccionados
              //     tabs: [
              //       Tab(child: Icon(Icons.home)),
              //       Tab(child: Icon(Icons.favorite)),
              //       Tab(child: Icon(Icons.notifications)),
              //       Tab(child: Icon(Icons.person)),
              //     ],
              //   ),
              // ),
              body: SafeArea(
                //el esqueleto del TabBar q esta en el homebuttonbar :D
                child: TabBarView(
                  //TabBarView ocupado para mostrar nuestras tabs, ocupa bn los recursos
                  controller: controller.tabController, //ocupando nuestro tabcontroller
                  children: const [
                    //nuestrostabs, el orden importa :D
                    HomeTab(),
                    FavoritesTab(),
                    // Container( antess jeje
                    //   alignment: Alignment.center,
                    //   child: Text("nofiticacion"),
                    // ),
                    NotificationsTab(),
                    ProfileTab(),
                  ],
                ),
              ),
            );
          },
          // ),
        );
      },
    );
  }
}
