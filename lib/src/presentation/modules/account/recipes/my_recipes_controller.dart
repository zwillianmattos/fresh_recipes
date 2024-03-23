import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/usecases/account/get_my_profile_use_case.dart';
import 'package:fresh_recipes/src/usecases/account/get_profile_recipes_use_case.dart';

class MyRecipeController {
  final Account account;
  MyRecipeController(this.account) {
    fetch();
  }
  final GetMyProfileRecipesUseCase getMyProfileRecipesUseCase = Modular.get<GetMyProfileRecipesUseCase>();
  final GetMyProfileUseCase getMyProfileUseCase = Modular.get<GetMyProfileUseCase>();
  final MyRecipePageState state = MyRecipePageState();
  fetch() async {
    try {
      state.loadingNotifier.value = true;
      var account = await getMyProfileUseCase.call();
      state.recipes.value = await getMyProfileRecipesUseCase.call(params: {
        'chef': account.id.toString(),
      });
    } catch (e) {
      state.errorNotifier.value = e.toString();
    } finally {
      state.loadingNotifier.value = false;
    }
  }
}

class MyRecipePageState {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<List<Recipe>> recipes = ValueNotifier<List<Recipe>>([]);
}
