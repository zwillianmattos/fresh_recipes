import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/services/ingredients_service.dart';

class IngredientsSearchPageController extends Disposable {
  IngredientsService ingredientsService = Modular.get<IngredientsService>();
  TextEditingController searchController = TextEditingController();

  TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController();

  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<List<Ingredient>> ingredients = ValueNotifier<List<Ingredient>>([]);

  ValueNotifier<Ingredients> ingredient = ValueNotifier<Ingredients>(Ingredients());

  IngredientsSearchPageController() {
    doSearch();
  }

  doSearch() async {
    isLoading.value = true;
    String search = searchController.text;
    print('Search $search');
    ingredients.value = await ingredientsService.get(query: search);
    isLoading.value = false;
  }

  @override
  void dispose() {
    searchController.dispose();
  }
}
