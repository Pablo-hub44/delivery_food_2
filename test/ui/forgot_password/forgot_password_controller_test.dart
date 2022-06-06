// ignore_for_file: unused_local_variable

import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dependency_injection.dart';

void main() {
  //inicialiamos nuestras dependencias al principio
  setUpAll(() async {
    TestDependencyInjection.initialize();
  });
  tearDownAll(() {
    TestDependencyInjection.clear(); //al final limpiamos los datos
  });

  group("forgotpassword controller", () {
    late ForgotPasswordController controller;
    // cada q se ejecute un test se ejecutara antes nuestro setup
    setUp(() {
      controller = ForgotPasswordController();
    });
    test("email == " "", () {
      expect(controller.email == "", true); //funciona
    });
    test("onEmailChanged", () {
      controller.onEmailChanged("test@test.com");
      expect(controller.email == "test@test.com", true); //funciona
    });

    test("submit email invalido", () async {
      bool catchCalled = false;
      try {
        controller.onEmailChanged("testtest.com");
        await controller.submit();
      } catch (e) {
        if (e is AssertionError) {
          catchCalled = true;
        }
      }
      expect(catchCalled, true); //funciona se convierte en true ya q da error assertionError
    });

    test("submit success", () async {
      controller.onEmailChanged("test@test.com");
      final result = await controller.submit();
      expect(result, true); //funciona
    });
  });
}
