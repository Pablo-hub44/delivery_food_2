//shared_preferences para guardar datos de forma local en el dispositivo
// debe usarse para guardar datos cortos y nos largos

// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const _key = "OnboardAndWelcome";

class PreferencesProvider {
  final SharedPreferences _preferences; //los datos que podrmos guradar localmente

  // contructor
  PreferencesProvider(this._preferences);

  // metodo para guardar que ya eh visitado las paginas de onboard y welcome
  Future<void> setOnboardAndWelcomeReady(bool ready) async {
    await _preferences.setBool(_key, ready); //ponemos future pk e lsetbool retorna un future
  }

  // meotdo que retorne un booleano, osease el get pa conseguir el dato del metodo
  bool get OnboardAndWelcomeReady {
    // retornaremos el booleano si no es nulo, sino nulo
    return _preferences.getBool(_key) ?? false; //el mismo nombre q le pusimo arriba
    // si esto es true navegaremos directamente a tal pagina
  }
}
