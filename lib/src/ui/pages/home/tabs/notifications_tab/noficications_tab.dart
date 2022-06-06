// import 'package:cached_network_image/cached_network_image.dart';
// ignore_for_file: prefer_const_constructors, must_call_super

import 'package:delivery_food/src/ui/global_controllers/notification_controller.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/notifications_tab/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

// AutomaticKeepAliveClientMixin nos ayudara a preservar el estado de nuestra pagina, nuestro tab, osease el scroll de donde se quedó
//y eso se tendria q poner en cada pestaña en la q querramos preservar el estado
class _NotificationsTabState extends State<NotificationsTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // escuchamos todo de nuestro notificationController
    final controller = context.watch<NotificationsController>();
    final notifications = controller.notifications; //de nuesta lista de notificaciones

    super.build(context); //llamar antes del return a esto, para q funcione keepAlive y le pasamos el contexto
    return ListView.builder(
      itemBuilder: (context, index) {
        final notification = notifications[index]; //index pa iterar en los datos de nuestra lista
        // widget propio y le pasamos las notification de arriba a nuestro widget
        return NotificationItem(
          notification: notification,
        );
        // ListTile( asi ya no
        //   title: Text(notification.title),
        // );
      },
      itemCount: notifications.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
  //con esto vamos a preservar el estado aqui en el notitab del TabBarView del home_page tiene q ser true

}
//ejemplo de como se usaba el widget hero
  //   return Container(
  //     alignment: Alignment.center,
  //     child: Column(
  //       children: [
  //         // GestureDetector pa q sea un boton
  //         GestureDetector(
  //           onTap: () {
  //             final route = MaterialPageRoute(
  //                 builder: (context) => HeroPage(
  //                       tag: 'tag1',
  //                     ));
  //             Navigator.push(context, route);
  //           },
  //           //el widget hero para hacer animaciones
  //           child: Hero(
  //             tag: 'tag1',
  //             //ClipOval widget q vuelve circular todo lo q este dentro :O
  //             child: ClipOval(
  //               child: CachedNetworkImage(
  //                 width: 100,
  //                 height: 100,
  //                 imageUrl:
  //                     "https://img.freepik.com/foto-gratis/tortillas-frescas-primer-plano-envueltas-verduras-carne_23-2148614464.jpg?w=740",
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             // Container(
  //             //   width: 100,
  //             //   height: 100,
  //             //   // decoration: BoxDecoration(
  //             //   //   color: Colors.red,
  //             //   //   shape: BoxShape.circle,
  //             //   // ),
  //             //   child:
  //             // ),
  //           ),
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             final route = MaterialPageRoute(
  //                 builder: (context) => HeroPage(
  //                       tag: 'tag2',
  //                     ));
  //             Navigator.push(context, route);
  //           },
  //           //el widget hero para hacer animaciones
  //           child: Hero(
  //             tag: 'tag2', //no puede haber tags iguales en hero
  //             //ClipOval widget q vuelve circular todo lo q este dentro :O
  //             child: ClipOval(
  //               child: CachedNetworkImage(
  //                 width: 100,
  //                 height: 100,
  //                 imageUrl:
  //                     "https://img.freepik.com/foto-gratis/tortillas-frescas-primer-plano-envueltas-verduras-carne_23-2148614464.jpg?w=740",
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  


//--------------
//el widget hero para hacer animaciones, aprendiendo a usarlo, el widget del q viene y al q va, tienen q ser hero y tener el mismo tag, con eso le
//da una animacion de transicion, lo recomendable es q su child sea el mismo widget :D
// class HeroPage extends StatelessWidget {
//   //para pasarle por parametro el HeroPage
//   final String tag;

//   const HeroPage({
//     Key key,
//     @required this.tag,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Container(
//           width: double.infinity,
//           child: Column(
//             children: [
//               Hero(
//                 tag: this.tag, //se lo pasaremos por parametro
//                 //tag: 'My-container', //el mismo valor q le pasamos arriba y gracias a esto le hace una animacion de escalado
//                 child: CachedNetworkImage(
//                   imageUrl:
//                       "https://img.freepik.com/foto-gratis/tortillas-frescas-primer-plano-envueltas-verduras-carne_23-2148614464.jpg?w=740",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
