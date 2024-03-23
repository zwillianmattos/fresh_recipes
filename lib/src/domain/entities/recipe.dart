import 'chef.dart';
import 'comment.dart';
import 'ingredient.dart';
import 'photo.dart';

class Recipe {
  int? id;
  String? title;
  String? description;
  String? time;
  String? difficulty;
  String? calories;
  String? proteins;
  String? carbs;
  String? fats;
  Chef? chef;
  List<Photos>? photos;
  List<Comments>? comments;
  List<Ingredients>? ingredients;
  List<Steps>? steps;

  Recipe({this.id, this.title, this.description, this.time, this.difficulty, this.calories, this.proteins, this.carbs, this.fats, this.steps, this.chef, this.photos, this.comments, this.ingredients});

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
    difficulty = json['difficulty'];
    calories = json['calories'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    chef = json['chef'] != null ? Chef.fromJson(json['chef']) : null;
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(Steps.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['time'] = time;
    data['difficulty'] = difficulty;
    data['calories'] = calories;
    data['proteins'] = proteins;
    data['carbs'] = carbs;
    data['fats'] = fats;
    data['steps'] = steps;
    if (chef != null) {
      data['chef'] = chef!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  String? step;
  String? photo;

  Steps({this.step, this.photo});

  Steps.fromJson(Map<String, dynamic> json) {
    step = json['step'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['step'] = step;
    data['photo'] = photo;
    return data;
  }
}
