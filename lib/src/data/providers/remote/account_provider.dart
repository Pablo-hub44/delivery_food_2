// esta clase se encargaria de realizar el consumo de las rutas de la API, q retornaria datos de un usuarios, etc
import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/local/authentication_client.dart';

class AccountProvider {
  // aqui simulariamos obtener el usuario de la api
  final AuthenticationClient _authenticationClient; //hacemos una variable de autheticationcliente
  AccountProvider(this._authenticationClient);

  Future<User?> get userInformation async {
    final token = _authenticationClient.token; //traemos el token

    // validamos si el token es nulo, q de un error
    if (token == null) {
      throw Exception('el token es nulo');
    }

    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '126309',
      name: "juan",
      email: "test@test.com",
      lastname: "Osi",
      cumple: DateTime(1993, 12, 1),
    );
  }
}
