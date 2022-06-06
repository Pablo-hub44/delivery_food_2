import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:delivery_food/src/ui/pages/home/home_controller.dart';
import 'package:delivery_food/src/ui/pages/home/tabs/fav_tab/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

// AutomaticKeepAliveClientMixin nos ayudara a preservar el estado de nuestra pagina, osease el scroll de donde se quedó
//y eso se tendria q poner en cada pestaña en la q querramos preservar el estado
class _FavoritesTabState extends State<FavoritesTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); //llamar antes del return a esto, para q funcione y le pasamos el contexto
    // print("tabb");

    final favoritos = context
        .select<HomeController, Map<int, Platillo>>((_) => _.favoritos)
        .values
        .toList(); //.select pa q escuche cambio de una propiedad en especifico de hometabcontroller, retorna la propiedad
    //aunque select no funciona muy bien con listas y por ello se hace un a copia, como se ve een homecontroller
    //List<Platillo>> cambiado ya que ahora ocuppamos un Map, pero lo convertimos a list pa q no de problemas

    return ListView.builder(
      //FavoriteItem nuestro widget con el q le daremos forma a este listbuiew.builder
      itemBuilder: (BuildContext context, index) => FavoriteItem(
        dish: favoritos[index], //favoritos en la posicion index
      ),
      itemCount: favoritos.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
  //con esto vamos a preservar el estado aqui en el favtab, del TabBarView del home_page tiene q ser true
}
