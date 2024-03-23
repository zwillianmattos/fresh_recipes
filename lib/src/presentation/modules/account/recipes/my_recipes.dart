import 'package:flutter/material.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/data/helper/display_dificult.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/presentation/modules/account/recipes/my_recipes_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/view_recipe.dart';

class ProfileMyRecipesTab extends StatefulWidget {
  final MyRecipeController controller;
  const ProfileMyRecipesTab({super.key, required this.controller});

  @override
  State<ProfileMyRecipesTab> createState() => _ProfileMyRecipesTabState();
}

class _ProfileMyRecipesTabState extends State<ProfileMyRecipesTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller.state.loadingNotifier,
        builder: (_, loading, __) {
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ValueListenableBuilder(
              valueListenable: widget.controller.state.recipes,
              builder: (context, recipes, __) {
                return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    recipes.length,
                    (index) {
                      Recipe recipe = recipes[index];
                      return RecipeCardMini(
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
                  ),
                );
              });
        });
  }
}
