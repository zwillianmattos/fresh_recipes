import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/datasources/local_storage.dart';

class DoLogoutUseCase {
  call() async {
    await LocalStorage.setValue<String>('account_profile', '');
    await LocalStorage.setValue<String>('account_token', '');
    Modular.to.pushReplacementNamed('/');
  }
}
