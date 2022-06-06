// ignore_for_file: non_constant_identifier_names

import 'package:delivery_food/src/data/providers/local/preferences_provider.dart';

//todo esto para
abstract class PreferencesRepository {
  Future<void> setOnboardAndWelcomeReady(bool ready);
  bool get onboardAndWelcomeReady;
}

// la implementacion
class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesProvider _provider;
  // el constructor para inicializar la propiedad
  PreferencesRepositoryImpl(this._provider);
  // sobreescribimos los metoodos

  @override
  Future<void> setOnboardAndWelcomeReady(bool ready) {
    return _provider.setOnboardAndWelcomeReady(ready);
  }

  @override
  bool get onboardAndWelcomeReady => _provider.OnboardAndWelcomeReady;
}
