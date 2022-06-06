//crear una clase que reprsenta un usuario de nuestra aplicaion

class User {
  final String id;
  final String name;
  final String email;
  final String lastname;
  final DateTime cumple;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.lastname,
    required this.cumple,
  }) {
    // ya no necesarias las valicaciones de nulos ya que no pueden serlo jeje
    // assert(id != null); //estamos diciendo que la instancia de la clase user va a ser creada siempre q id sea distinto de null
    // assert(name != null, "name cant be noun"); //(la validacion, mensaje personalizado)
    assert(email.contains("@"), "email cant be noun");
    // assert(lastname != null); //que todos no puedan ser nulos
    // assert(cumple != null);
  }
  //podemos hacer la validacion utilizando el cuerpo del constructor, o con :
  // se  usa assert para validar que se pasen bien los datos, como q no sean nulos
  // una propiedad puede tener muchas validaciones

  // manera con :
  // :assert(id != null),assert(name != null), etc
}
