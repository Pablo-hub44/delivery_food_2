// ignore_for_file: prefer_final_fields

// import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/local/authentication_client.dart';
// import 'package:delivery_food/src/data/providers/remote/account_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const key = 'token'; //podrimos reemplazar esto a los de abajo

// simularemos el comportamiento de AuthenticationClient
class MockAuthenticationClient implements AuthenticationClient {
  // Map<String, dynamic> _data = {}; //donde almacenaremos el 'token' y otras cosas //ejem "hola": 2, antes lo usabamos
  final SharedPreferences preferences;
  // constructor
  MockAuthenticationClient(this.preferences);
  @override
  Future<void> saveToken(String token) async {
    // _data['token'] = token;    | en ves de usar crear el map y guadar el token ahi, usamos de una ves el shared preferences y con su meto setstring como ya sabiamos creamo el 'token' y ya
    await preferences.setString('token', token);
  }

  @override
  Future<void> sighOut() async {
    // _data.remove("token"); antes
    await preferences.remove('token');
  }

  @override
  String? get token => preferences.getString('token');
  // => _data['token'] as String?;
}
