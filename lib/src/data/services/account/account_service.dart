import 'package:fresh_recipes/src/data/helper/header.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/services/account_service.dart';
import 'package:uno/uno.dart';

class AccountServiceImpl implements AccountService {
  final Uno http;
  AccountServiceImpl(this.http);
  @override
  String get endpoint => '/account';
  @override
  Future<Account> getProfile() async {
    Response response = await http.get(
      endpoint,
      headers: await headers(authorizer: true),
    );
    if (response.status != 200) {
      throw response.data['message'];
    }
    return Account.fromJson(response.data);
  }

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1}) {
    throw UnimplementedError();
  }
}
