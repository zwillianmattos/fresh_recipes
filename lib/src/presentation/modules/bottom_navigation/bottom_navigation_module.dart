import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/services/account/account_service.dart';
import 'package:fresh_recipes/src/data/services/image/upload_service.dart';
import 'package:fresh_recipes/src/data/services/recipes/recipes_service.dart';
import 'package:fresh_recipes/src/domain/services/account_service.dart';
import 'package:fresh_recipes/src/domain/services/image_service.dart';
import 'package:fresh_recipes/src/domain/services/recipe_service.dart';
import 'package:fresh_recipes/src/presentation/modules/account/account_module.dart';
import 'package:fresh_recipes/src/presentation/modules/bottom_navigation/bottom_navigation.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/home_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/create/create_recipe_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/recipes_module.dart';
import 'package:fresh_recipes/src/usecases/recipes/create/add_recipe.dart';
import 'package:fresh_recipes/src/usecases/recipes/get_recipes_fy_case.dart';

class BottomNavigationModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<AccountService>(AccountServiceImpl(i.get()));
    i.addInstance<RecipeService>(RecipesServiceImpl(i.get()));
    i.addInstance<ImageUploadService>(ImageUploadServiceImpl(i.get()));
    i.addSingleton(AddRecipeUseCase.new);
    i.addSingleton(GetRecipesFyCase.new);
    i.addSingleton(CreateRecipePageController.new);
    i.addSingleton(HomePageController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (c) => const BottomNavigation(), children: [
      ModuleRoute(
        '/account',
        module: AccountModule(),
      ),
      ModuleRoute(
        '/recipes',
        module: RecipesModule(),
      ),
      ChildRoute('/search', child: (_) => const Scaffold()),
    ]);
  }
}
