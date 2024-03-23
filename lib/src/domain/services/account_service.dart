import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/services/base_service.dart';

abstract class AccountService implements BaseService {
  Future<Account> getProfile();
}
