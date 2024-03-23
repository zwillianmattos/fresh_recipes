import 'package:fresh_recipes/src/data/helper/header.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/services/ingredients_service.dart';
import 'package:uno/uno.dart';

class IngredientsServiceImpl implements IngredientsService {
  final Uno http;
  IngredientsServiceImpl(this.http);

  @override
  String get endpoint => '/ingredients';

  @override
  Future<List<Ingredient>> get({String? query}) async {
    Response response = await http.get(
      '$endpoint?search=$query',
      headers: await headers(),
      responseType: ResponseType.json,
    );
    List<Ingredient> ingredients = [];
    if (response.status == 200) {
      final items = response.data;
      for (Map<String, dynamic> value in items) {
        ingredients.add(Ingredient.fromJson(value));
      }
    }
    return ingredients;
  }

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1}) {
    throw UnimplementedError();
  }
}
