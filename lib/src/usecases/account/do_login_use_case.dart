import 'dart:convert';

import 'package:fresh_recipes/src/data/datasources/local_storage.dart';
import 'package:fresh_recipes/src/data/models/account/auth/login_dto.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/services/auth_service.dart';

class DoLoginUseCase {
  final AuthService authService;
  DoLoginUseCase(this.authService);

  Future<Account> call(LoginDto loginRequest) async {
    Account account = await authService.login(loginRequest);
    await LocalStorage.setValue<String>('account_profile', jsonEncode(account));
    await LocalStorage.setValue<String>('account_token', account.token);
    return account;
  }
}
