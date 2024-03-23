import 'dart:async';

import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/domain/services/recipe_service.dart';

class GetRecipesFyCase {
  final RecipeService recipeService;

  GetRecipesFyCase(this.recipeService);

  Future<List<Recipe>> call({
    String? query,
    int limit = 10,
    int page = 1,
  }) async {
    print('calling_api');
    List<Recipe> recipes = await recipeService.paginate(
      query: query,
      limit: limit,
      page: page,
    );
    return recipes;
  }
}
