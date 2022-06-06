//los providers aca, referencia a la fuente de donde obtenemos nuestros datos

import 'dart:convert';

import 'package:delivery_food/src/data/modelos/platillo.dart';
import 'package:flutter/services.dart';

class FoodMenuProvider {
  //si el metodo regresa un future tenemos q ponerle async y await, ya q es un metodo q necesita tiempo
  //esta clase se va a encargar de conseguir nuestro json
  Future<List<Platillo>> getPopularMenu() async {
    final jsonAsString = await rootBundle.loadString('assets/pages/home/home_tab/json/menu_popular.json');
    //loadString de esta forma estamos leyendo el json como un string, de donde va a sacr los datos

    final List list =
        jsonDecode(jsonAsString); //List<Map<String,dynamic>> ya que nuestro json es una lista de maps, no works jaja, solo list

    List<Platillo> dishes = [];

    // hacer un for para iterar en la list decodificada de nuestro json, como item (referencia a los elementos de la lista) y lo igualamos con los datos de nuestro modelo Platillo
    for (final Map<String, dynamic> item in list) {
      final dish = Platillo(
        //nuestra instancia q la igualamos con los datos de la lista
        id: item['id'], //id del modelo, item del json
        name: item['name'],
        image: item['preview'],
        price:
            double.parse(item['price'].toString()), //asi hacemos q nuestros enteros sean doubles y no alla problema con el json
        rate: item['rate'] != null
            ? double.parse(item['rate'].toString()) // pero afuerzas quiere el dart q sea String asi q los ponemos con .toString
            : null,
        description: item['description'],
      );
      dishes.add(dish); //agregamos esta instancia a la lista dishes
    }
    return dishes;
  }
}
