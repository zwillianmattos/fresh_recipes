import 'package:fresh_recipes/src/data/models/recipes/create_recipe_dto.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/domain/services/recipe_service.dart';

class AddRecipeUseCase {
  final RecipeService recipeService;

  AddRecipeUseCase(this.recipeService);

  Future<Recipe?> call(CreateRecipeDto createRecipeDto) async {
    try {
      Recipe newRecipe = await recipeService.create(createRecipeDto);
      return newRecipe;
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
