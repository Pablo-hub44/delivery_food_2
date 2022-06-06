import 'package:delivery_food/src/data/modelos/user.dart';
// import 'package:delivery_food/src/data/providers/remote/authentication_provider.dart';
import 'package:delivery_food/src/data/repositorios/authentication_repo.dart';
import 'package:delivery_food/src/helpers/get.dart';
import 'package:delivery_food/src/ui/global_widgets/custom_form.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  String _email = '';
  String _name = '';
  String _lastname = '';
  //nuestra variable de tipo auteticcation con parametro authprovider
  // final AuthenticationRepository _repository = AuthenticationRepositoryImplementation(AuthenticationProvider());
  final AuthenticationRepository _repository = Get.i.find<AuthenticationRepository>(tag: "auth"); // opcion dos con get
  GlobalKey<CustomFormState> formkey = GlobalKey(); //usada para asignarla a CustomForm en register_form

  // conseguimos los valores privamos con get, pa poder testear
  String get email => _email;
  String get name => _name;
  String get lastname => _lastname;

  void onEmailChanged(String text) {
    _email = text;
  }

  void onNamelChanged(String text) {
    _name = text;
  }

  void onLastnameChanged(String text) {
    _lastname = text;
  }

  Future<bool> submit() async {
    return _repository.register(
      User(
        id: DateTime.now().toString(), //null,
        name: _name,
        email: _email,
        lastname: _lastname,
        cumple: DateTime(2000, 1, 23),
      ),
    );
    // return true;
  }
}
