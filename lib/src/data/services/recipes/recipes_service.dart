import 'package:fresh_recipes/src/data/helper/header.dart';
import 'package:fresh_recipes/src/data/models/recipes/create_recipe_dto.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/domain/services/recipe_service.dart';
import 'package:uno/uno.dart';

class RecipesServiceImpl implements RecipeService {
  final Uno http;
  RecipesServiceImpl(this.http);
  @override
  String get endpoint => '/recipes';

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1, Map<String, String>? params}) async {
    Response response = await http.get(
      endpoint,
      params: params ?? {},
      headers: await headers(),
      responseType: ResponseType.json,
    );
    List<T> recipes = [];
    if (response.status == 200) {
      final items = response.data['items'];
      for (Map<String, dynamic> value in items) {
        recipes.add(Recipe.fromJson(value) as T);
      }
    }
    return recipes;
  }

  @override
  Future<Recipe> create(CreateRecipeDto createRecipeDto) async {
    try {
      // 201 -> create
      // 400 -> appplication error
      // 500 -> server error
      Response response = await http.post(
        endpoint,
        data: createRecipeDto.toJson(),
        headers: await headers(
          authorizer: true,
        ),
      );
      if (response.status != 201) {
        throw Exception(response.data['message']);
      }
      Recipe recipe = Recipe.fromJson(response.data);
      return recipe;
    } catch (e) {
      if (e is UnoError) {
        throw Exception(e.response?.data['message']);
      }
      throw Exception('Erro durante o login: $e');
    }
  }
}
