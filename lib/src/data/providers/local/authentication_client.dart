// para guardar la autenticacion el token de forma local

// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';

const _key = "token"; //con esto podriamos sustituir todos los "token"

class AuthenticationClient {
  final SharedPreferences _preferences; //donde se guardara de forma local, guardara la info tipo texto plano
  // pa guardar datos sensibles mejor usar flutter_secure_storage

  // constructor
  AuthenticationClient(this._preferences);

  // metodo pa guardar el token
  Future<void> saveToken(String token) async {
    await _preferences.setString("token", token); //el nombre y el parametro
  }

  // metodo para borrar el token
  Future<void> sighOut() async {
    await _preferences.remove("token"); //el nombre y el parametro
  }

  // conseguir el 'token'
  String? get token {
    return _preferences.getString("token");
  }
}
