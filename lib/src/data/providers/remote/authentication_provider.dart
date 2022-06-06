import 'package:delivery_food/src/data/modelos/user.dart';

class AuthenticationProvider {
  //aqui podriamos poner de firebase etc
  //el future es porque la consulta a la api podria tardar 2 o 3 seg
  Future<String?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); //para darle tiempo, pa que se ejecute
    if (email == 'test@test.com' && password == '12345') {
      final String token =
          DateTime.now().millisecondsSinceEpoch.toString(); //q sea como un tipo token, q disque retorno la api xd
      // return User( movido a acount provider
      //   id: '126309',
      //   name: "juan",
      //   email: "test@test.com",
      //   lastname: "Osi",
      //   cumple: DateTime(1993, 12, 1),
      // );
      return token;
    } else {
      return null;
    }
  }

  //metodo de registro
  Future<bool> register(User user) async {
    await Future.delayed(const Duration(seconds: 2)); //para darle tiempo, pa que se ejecute
    return true;
  }

  //metodo de recuperar contraseña
  Future<bool> sendResetToken(String email) async {
    // print("jaja email ${email}");
    await Future.delayed(const Duration(seconds: 2)); //para darle tiempo, pa que se ejecute
    return true; //este valor definita si pasa o no, por defecto siempre sera true solo con que ponga un email pasa
  }
}
