//aqui vamnos a definir la funcion, que datos recibe y que datos retorna
import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';

//interfaz
// el patron repositorio - ver mas info sobre ello, ya q lo ocupamos la estructura
abstract class AuthenticationRepository {
  //las clases abstracta dentro solo tienen atributos y metodos sin cuerpo, de los providers
  Future<String?> login(String email, String password); //antes de tipo User?
  Future<bool> register(User user);
  Future<bool> sendResetToken(String email);
  Future<void> saveToken(String token);
  Future<void> signOut();
  String? get token;
}

//la implementacion
//2. crear una clase que implemente lo de arriba
class AuthenticationRepositoryImplementation implements AuthenticationRepository {
  final AuthenticationProvider _authenticationProvider;
  final AuthenticationClient _authenticationClient;
  //es mejor que el valor de esta propiedad sea proporcionada al momento de crear una instancia

  // constructor
  AuthenticationRepositoryImplementation(this._authenticationProvider, this._authenticationClient);
  @override
  Future<String?> login(String email, String password) {
    return _authenticationProvider.login(email, password); //este login es del provider
  }

  @override
  Future<bool> register(User user) {
    return _authenticationProvider.register(user);
  }

  @override
  Future<bool> sendResetToken(String email) {
    return _authenticationProvider.sendResetToken(email);
  }

// guardar el token
  @override
  Future<void> saveToken(String token) {
    return _authenticationClient
        .saveToken(token); //con el _autenticatioclient q definimos, llamamos al metodo savetoken y le pasamos el token
  }

// para recuperar el token
  @override
  String? get token => _authenticationClient.token;
  //? pk podria ser nulo

  @override
  Future<void> signOut() {
    return _authenticationClient.sighOut(); //llamamos el metodo de authentication client que seria como su provider
  }
}
