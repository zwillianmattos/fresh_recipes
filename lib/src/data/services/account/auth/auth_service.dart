import 'package:fresh_recipes/src/data/helper/header.dart';
import 'package:fresh_recipes/src/data/models/account/auth/login_dto.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/services/auth_service.dart';
import 'package:uno/uno.dart';

class AuthServiceImpl implements AuthService {
  final Uno http;
  AuthServiceImpl(this.http);
  @override
  String get endpoint => '/account';
  @override
  Future<Account> login(LoginDto loginRequestDto) async {
    try {
      Response response = await http.post(
        '$endpoint/login',
        data: loginRequestDto.toJson(),
        headers: await headers(authorizer: false),
      );
      final Map<String, dynamic> responseData = response.data;
      return Account.fromJson(responseData);
    } catch (e) {
      if (e is UnoError) {
        String message = e.response != null ? e.response?.data['message'] : e.message;
        throw UnoError(message);
      }
      throw Exception('Internal Server Error');
    }
  }

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1}) {
    throw UnimplementedError();
  }
}
