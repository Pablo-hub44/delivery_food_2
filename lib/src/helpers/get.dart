//clase para inyeccion dee dependencias
// ignore_for_file: prefer_final_fields, prefer_collection_literals, unnecessary_this

// le agregaremo una nueva funcionalidad
typedef _LazyCallback<T> = T Function(); //nuestro typedef personalizado

class Get {
  //es un sigleton, osease que desde cualquier parte de nuestro codigo sera la misma instancia

  Get._(); //constructor privado
  static Get i = Get._();

  Map<String, dynamic> _data = Map(); //en data vamos a guardar nuestras dependencias
  Map<String, _LazyCallback> _lazyData = {}; //lazy donde vamo a guardar otro tipo de nuestras dependencias

//String? pa que pueda aceptar tambien nulos
//metodo pa obtener llave, ya q gracias al tag podremos tener mas depenceiasinyection del mismo tipo ysaber cual es cual
  String _getKey(Type t, String? tag) {
    if (tag != null) {
      return "${t.toString()} $tag";
    }
    return t.toString();
  }

  //funcion que va a guardar la dependecia en el  map data
  void put<T>(T dependencia, {String? tag}) {
    final String key = _getKey(T, tag); // = T.toString(); antes
    // print("key $key");
    _data[key] = dependencia;
  }

  //para poder inyectar un dependencia que no la vamos a necesitar en ese momento
  //funcion para un put diferente, think q hace que no tengamos que poner streamcontroller algo asi
  void lazyPut<T>(_LazyCallback<T> dependencia, {String? tag}) {
    final String key = _getKey(T, tag); // = T.toString(); antes
    // print("key $key");
    _lazyData[key] = dependencia;
  }

  //funcion que lo va a recuperar, buscar el authenticationRepository en el map _data//agregado el lazy si es true q guarde en el otro map
  T find<T>({String? tag, bool lazy = false}) {
    final String key = _getKey(T, tag); // = T.toString(); antes

    final insideData = _data.containsKey(key); //retornara true o false, par saber si existe o no

    // validamos que si esta en el map _data normal
    if (insideData) {
      //si es true... , el data normal
      return _data[key];
    }

    // print("find key $key");
    if (lazy == true) {
      // validamos, comprobamos que la key este en nuestro map lazydata
      if (!_lazyData.containsKey(key)) {
        throw AssertionError("$key no encontrada, asegurate de llamar primero a lazyput"); //AssertionError error de pantalla roja
      } //sino hay error q lo ponga en lazydata
      final dependency = _lazyData[key]!();
      this.put<T>(dependency, tag: tag); //inyectamos la dependencia en el put normal
      // return _lazyData[key]!();
      return dependency;
    }

    //si no esta DependencyInjection nuestra inyeccion , antes
    // if (!_data.containsKey(key)) {
    //   throw AssertionError("$key no encontrada, asegurate de llamar primero al put"); //AssertionError error de pantalla roja
    // }
    // return _data[key];
    // simplemente si no cumple ni insideData, ni lazy, error
    throw AssertionError("tag $key no encontrada, asegurate de llamar primero al put");
  }

  //funcion para eliminar una dependencia de nuestro map
  void remove<T>({String? tag}) {
    final String key = _getKey(T, tag); // = T.toString(); antes, recuperamos la llave
    // print("find key $key");
    _data.remove(key);
  }

  // version 2
  bool removee<T>({String? tag}) {
    final String key = _getKey(T, tag); // = T.toString(); antes, recuperamos la llave
    // validamos que si contiene la key lo borre y retorne true
    if (_data.containsKey(key)) {
      _data.remove(key);
      // print("find key $key");
      return true;
    } else {
      // sino false
      return false;
    }
  }

  // usados para testear
  // esta funcion se va a encargar delimpiar los datos de nuestro map data
  int clear() {
    final count = _data.length; //vamos a contar los datos limpiados
    _data.clear();
    return count;
  }

  // para q limpiar igual, pero el lazy put
  int clearLazy() {
    final count = _lazyData.length; //vamos a contar los datos limpiados
    _data.clear();
    return count;
  }
}
