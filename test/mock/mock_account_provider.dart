import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/remote/account_provider.dart';

// simularemos el comportamiento de AccountProvider
class MockAccountProvider implements AccountProvider {
  final AuthenticationClient authenticationClient;

  MockAccountProvider(this.authenticationClient); // simular este proceso para simular el proceso de q neceitamos un token
  @override
  Future<User?> get userInformation async {
    final token = authenticationClient.token;
    assert(token != null, 'token es nulo'); //validamos que no sea nulo , si lo es = mensaje

    return User(
      id: '126309',
      name: "juan",
      email: "test@test.com",
      lastname: "Osi",
      cumple: DateTime(1993, 12, 1),
    );
  }
}
