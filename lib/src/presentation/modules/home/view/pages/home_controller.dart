import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/usecases/recipes/get_recipes_fy_case.dart';

class HomePageController extends Disposable {
  GetRecipesFyCase getRecipesFy;

  final HomeState state = HomeState();

  HomePageController(this.getRecipesFy) {
    fetchRecipesFy();
  }

  fetchRecipesFy() async {
    state.loadingNotifier.value = true;
    try {
      state.dataNotifier.value = await getRecipesFy.call();
    } catch (e) {
      state.errorNotifier.value = e.toString();
    }
    state.loadingNotifier.value = false;
  }

  @override
  void dispose() {}
}

class HomeState {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<List<Recipe>> dataNotifier = ValueNotifier<List<Recipe>>([]);
}
