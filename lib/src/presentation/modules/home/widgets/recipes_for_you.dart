import 'package:flutter/material.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/data/helper/display_dificult.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/home_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/view_recipe.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../domain/entities/recipe.dart';

class RecipesForYou extends StatefulWidget {
  final HomePageController controller;

  const RecipesForYou({super.key, required this.controller});

  @override
  State<RecipesForYou> createState() => _RecipesForYouState();
}

class _RecipesForYouState extends State<RecipesForYou> {
  Future<void> _refresh() async {
    if (!widget.controller.state.loadingNotifier.value) {
      await widget.controller.fetchRecipesFy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.controller.state.loadingNotifier,
        builder: (_, loading, __) {
          return ValueListenableBuilder<String?>(
            valueListenable: widget.controller.state.errorNotifier,
            builder: (context, error, _) {
              if (error != null) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Erro: Internal error \n $error',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.controller.fetchRecipesFy();
                        },
                        child: Text(
                          'Reload',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }

              return ValueListenableBuilder<List<Recipe>>(
                valueListenable: widget.controller.state.dataNotifier,
                builder: (context, recipes, _) {
                  return ListView.builder(
                    itemBuilder: (__, index) {
                      final Recipe recipe = recipes[index];
                      return RecipeCard(
                        photoUrl: recipe.photos!.first.url!,
                        title: recipe.title!,
                        description: recipe.description!,
                        profilePhoto: '${recipe.chef!.account?.profilePhoto!}',
                        proileName: '${recipe.chef!.account?.name!}',
                        recipeCalories: '${recipe.calories}',
                        recipeTime: '${recipe.time}',
                        recipeLevel: displayDificult(recipe.difficulty),
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailPage(recipe: recipe),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: recipes.length,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
