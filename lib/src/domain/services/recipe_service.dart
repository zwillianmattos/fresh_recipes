import 'package:fresh_recipes/src/data/models/recipes/create_recipe_dto.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';

import 'base_service.dart';

abstract class RecipeService implements BaseService {
  RecipeService();

  @override
  Future<List<T>> paginate<T>({String? query, int limit = 10, int page = 1, Map<String, String>? params});

  Future<Recipe> create(CreateRecipeDto createRecipeDto);
}
