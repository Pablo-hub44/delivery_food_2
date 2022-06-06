// simularemos el comportamiento de AuthenticationProvider
import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';

class MockAuthenticationProvider implements AuthenticationProvider {
  @override
  Future<String?> login(String email, String password) async {
    if (email == 'test@test.com' && password == '12345') {
      final String token =
          DateTime.now().millisecondsSinceEpoch.toString(); //q sea como un tipo token, q disque retorno la api xd
      return token;
    } else {
      return null;
    }
  }

  @override
  Future<bool> register(User user) async {
    return true;
  }

  @override
  Future<bool> sendResetToken(String email) async {
    return true;
  }
}
