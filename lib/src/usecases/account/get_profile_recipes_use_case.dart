import 'package:fresh_recipes/src/domain/services/recipe_service.dart';

import '../../domain/entities/recipe.dart';

class GetMyProfileRecipesUseCase {
  final RecipeService recipeService;

  GetMyProfileRecipesUseCase(this.recipeService);

  Future<List<Recipe>> call({
    String? query,
    int limit = 10,
    int page = 1,
    Map<String, String>? params,
  }) async {
    List<Recipe> recipes = await recipeService.paginate(query: query, limit: limit, page: page, params: params);

    return recipes;
  }
}
