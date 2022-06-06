// ignore_for_file: unused_local_variable, avoid_print

import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/ui/pages/login/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';
import 'package:delivery_food/src/helpers/get.dart';

void main() {
  late LoginController loginController;
  // setupall se ejecuta al principio antes de todos los test y grupos
  setUpAll(() async {
    await TestDependencyInjection.initialize(); //inicializamos nuestras cosas
    loginController = LoginController();
  });

  // teardownAll se ejecuta al final de todos los grupos y todos los test
  tearDownAll(() {
    TestDependencyInjection.clear();
  });
  group('loginController', () {
    // vamos a testear la recepcion del email
    test('onEmailchanged', () {
      expect(loginController.email, ''); //por defecto es nulo
      loginController.onEmailChanged("test@gmail.com");
      expect(loginController.email, 'test@gmail.com');
    });
    test('onPasswordchanged', () {
      expect(loginController.password, ''); //por defecto es nulo
      loginController.onPasswordChanged("12345");
      expect(loginController.password, '12345');
    });

    // probando enviando un correo invalido
    test('submit failes', () async {
      loginController.onEmailChanged("test@gmail.com");
      loginController.onPasswordChanged("assas");
      // print(loginController.password);
      final user = await loginController.submit();
      expect(user == null, true); //tiene q ser true ya q le estamos diciendo q es nulo pk la contraseña es mala
    });

    test('submit success', () async {
      loginController.onEmailChanged("test@test.com");
      loginController.onPasswordChanged("12345");
      // print(loginController.password);
      final user = await loginController.submit();
      // expect(user == null, true); //daria error ya q ahora si tiene el email y contraseña correctas
      // expect(user != null, true);
      expect(user, isA<User>());
      final token = Get.i.find<AuthenticationRepository>(tag: 'auth').token; //traemo el token, ya q accedio el user correcto
      expect(token != null, true);
    });
  });
}
