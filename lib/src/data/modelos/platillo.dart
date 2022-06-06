// ignore_for_file: unnecessary_this

class Platillo {
  final int id;
  final String name;
  final double price;
  final double? rate; //solo rate acepte valores nulos
  final String image;
  final String description;
  final int counter; //aca vamos a guardar el num de elementos que seleccione

  Platillo({
    required this.id,
    required this.name,
    required this.price,
    required this.rate,
    required this.image,
    required this.description,
    this.counter = 0,
  }) {
    //le vamos a poner validaciones a la clase con assert para que se instancie sin q halla errores :D
    // ya no usado pk con null safety no pueden ser nulos :D
    // assert(id != null);
    // assert(name != null);
    // assert(image != null);
    // assert(price != null);
    // assert(description != null);
  }

  //funcion que permite actualizar el valor del counter
  //estonces este metodo lo que hace es retornarnos una copia de Platillo pero modifica la propiedad counter
  Platillo updatecounter(int counter) {
    // retornamos una instancia de la clase platillo
    return Platillo(
      id: this.id,
      name: this.name,
      description: this.description,
      price: this.price,
      rate: this.rate,
      image: this.image,
      counter: counter, //sera al que le pasamos por parametro
    );
  }
}

// {
//         "id": 123,
//         "name": "Tacos de Fabali",
//         "price": 9.99,
//         "rate": 4.5,

//         "preview": "https://img.freepik.com/foto-gratis/tortillas-frescas-primer-plano-envueltas-verduras-carne_23-2148614464.jpg?w=740"
//     },
