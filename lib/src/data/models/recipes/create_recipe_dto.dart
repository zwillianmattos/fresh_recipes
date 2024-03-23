// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';

class CreateRecipeDto {
  String title;
  String description;
  String time;
  String difficulty;
  String? calories;
  String? proteins;
  String? carbs;
  String? fats;
  List<int>? photos;
  List<Ingredients> ingredients;
  List<Steps> steps;

  CreateRecipeDto({
    required this.title,
    required this.description,
    required this.time,
    required this.difficulty,
    this.calories,
    this.proteins,
    this.carbs,
    this.fats,
    this.photos,
    required this.ingredients,
    required this.steps,
  });

  String toJson() => json.encode(
        <String, dynamic>{
          'title': title,
          'description': description,
          'time': time,
          'difficulty': difficulty,
          'calories': calories,
          'proteins': proteins,
          'carbs': carbs,
          'fats': fats,
          'photos': photos,
          'ingredients': ingredients.map((x) => x.toJson()).toList(),
          'steps': steps.map((x) => x.toJson()).toList(),
        },
      );
}
