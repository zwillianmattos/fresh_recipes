import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/home_page.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/create/create_recipe_page.dart';

class RecipesModule extends Module {
  @override
  void binds(i) async {}

  @override
  void routes(r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/create', child: (_) => const CreateRecipePage());
    r.child('/favorites', child: (_) => const Scaffold());
  }
}
