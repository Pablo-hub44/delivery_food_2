import 'package:delivery_food/src/data/modelos/user.dart';
import 'package:delivery_food/src/data/providers/remote/account_provider.dart';

abstract class AccountRepository {
  Future<User?> get userInformation;
}

// la implementacion donde se reescribiran los metodos
class AccountRepositoryImpl implements AccountRepository {
  final AccountProvider _provider;

  AccountRepositoryImpl(this._provider);

  @override
  Future<User?> get userInformation => _provider.userInformation;
}
