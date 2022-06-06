import 'package:delivery_food/src/data/modelos/user.dart';
// import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/account_repository.dart';
// import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/helpers/get.dart';
// import 'package:delivery_food/src/helpers/get.dart';
// import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter/material.dart';

//en los controller nada de usar Buildcontext context

class LoginController extends ChangeNotifier {
  //variables q van a tener estado :D
  String _email = '';
  String _password = '';

  // recuperamos con get las prpiedades privadas
  String get email => _email;
  String get password => _password;

  // final _api = AuthenticationAPI();
  // final AuthenticationRepository _repository = AuthenticationRepositoryImplementation(AuthenticationProvider());
  final AuthenticationRepository _authenticationRepository = Get.i.find<AuthenticationRepository>(
      tag: "auth"); // opcion dos con get, el tag no es obligatorio solo es para referenciarlo del _getKey, no usado dentro del ()
  final _accountRepository = Get.i.find<AccountRepository>();

  //metodo
  void onEmailChanged(String text) {
    _email = text;
  }

  void onPasswordChanged(String text) {
    _password = text;
  }

//metodo pa consultar la api , base de datos,  etc
  Future<User?> submit() async {
    // final User user = await _api.login(_email, _password);
    // assert(_email != null && _password != null); //podemos validar que no sea nulos los datos, ya no necesario
    final String? token = await _authenticationRepository.login(_email, _password); //antes no tenia nada de token
    // validamos q no sea nulo
    if (token != null) {
      await _authenticationRepository.saveToken(token); //guardamos el token
      return _accountRepository.userInformation;
    } else {
      return null;
    }
    // if (user != null) {
    //   print("login ok");
    // } else {
    //   print("error de login");
    // }
  }
}

// en el backend
// recibimos los datos como json string, los conbertimos a objetos y etc, pero enviamos las response como json
// para en el front con angular hacer un tipo json.parse, con .subscribe response decodificar la response a un objeto
// e igualar los valores de la response con los de nuestro objeto de angular