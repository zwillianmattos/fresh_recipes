import 'dart:convert';

import 'package:fresh_recipes/src/data/datasources/local_storage.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/services/account_service.dart';

class GetMyProfileUseCase {
  final AccountService accountService;

  GetMyProfileUseCase(this.accountService);

  Future<Account> call() async {
    Map<String, dynamic> accountData = jsonDecode(await LocalStorage.getValue<String>('account_profile'));
    Account account = Account.fromJson(accountData);
    return account;
  }
}
