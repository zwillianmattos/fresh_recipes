import 'package:fresh_recipes/src/data/datasources/local_storage.dart';

Future<Map<String, String>> headers({Map<String, String>? headers, bool authorizer = false}) async {
  Map<String, String> headerData = {
    ...?headers
  };
  if (authorizer) {
    final token = await LocalStorage.getValue<String>('account_token');
    headerData['Authorization'] = 'Bearer $token';
  }

  return {
    'Content-Type': 'application/json',
    ...headerData,
  };
}
