// import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:flutter/cupertino.dart';

class ForgotPasswordController extends ChangeNotifier {
  //variable que tendra estado :D
  String _email = '';

  String get email => _email; //pa conseguir la variable, ya que era privada

  // final AuthenticationRepository _repository = AuthenticationRepositoryImplementation(AuthenticationProvider());
  final AuthenticationRepository _repository = Get.i.find<AuthenticationRepository>(
      tag: "auth"); // opcion dos con get, el tag no es obligatorio solo es para referenciarlo del _getKey

  //metodo que escuchara cambios del onchaged de email, osease lo que se escriba en email
  void onEmailChanged(String text) {
    _email = text;
  }

  //metodo submit
  Future<bool> submit() {
    assert(_email.contains("@"), 'Email invalido');
    return _repository.sendResetToken(_email);
  }
}
