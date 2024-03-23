import 'package:fresh_recipes/src/data/models/account/auth/login_dto.dart';
import 'package:fresh_recipes/src/domain/services/base_service.dart';

import '../entities/account.dart';

abstract class AuthService implements BaseService {
  Future<Account> login(LoginDto loginRequestDto);
}
