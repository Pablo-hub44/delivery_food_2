// ignore_for_file: unused_local_variable, prefer_final_fields

import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// archivo no usado, basura jeje
void main(List<String> args) {
  test("authentication", () async {
    TestWidgetsFlutterBinding.ensureInitialized(); //necesario poner estos 2 para testear
    SharedPreferences.setMockInitialValues({});

    final prefs = await SharedPreferences.getInstance(); //para pasarselo a autenticationclient
    final authenticationProvider = AuthenticationProvider();
    final authenticationClient = AuthenticationClient(prefs);

    final AuthenticationRepository repository =
        AuthenticationRepositoryImplementation(authenticationProvider, authenticationClient);

    // final AuthenticationRepository repository = MockAuthenticationRepository();
  });
}

// al final ya no la usamos Xd
//otra forma, reescribiendo los metodos de AuthenticationRepository
// class MockAuthenticationRepository implements AuthenticationRepository {
//   Map<String, dynamic> _data = {};
//   @override
//   Future<String?> login(String email, String password) async {
//     if (email == 'test@test.com' && password == '12345') {
//       final String token =
//           DateTime.now().millisecondsSinceEpoch.toString(); //q sea como un tipo token, q disque retorno la api xd
//       return token;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<bool> register(User user) async {
//     await Future.delayed(const Duration(seconds: 1)); //para darle tiempo, pa que se ejecute
//     return true;
//   }

//   @override
//   Future<void> saveToken(String token) async {
//     _data['token'] = token; //guardamos es nuestro map el token, asignamos a token
//   }

//   @override
//   Future<bool> sendResetToken(String email) async {
//     return true;
//   }

//   @override
//   Future<void> signOut() async {
//     // eliminamos de data nuestro token
//     _data.remove('token');
//   }

//   @override
//   String? get token => _data['token'] as String?; //? pk podria ser nulo
// }

