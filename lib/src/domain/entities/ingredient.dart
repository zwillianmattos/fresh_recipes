class Ingredients {
  int? id;
  num? quantity;
  String? unit;
  Ingredient? ingredient;

  Ingredients({this.id, this.quantity, this.unit, this.ingredient});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    unit = json['unit'];
    ingredient = json['ingredient'] != null ? Ingredient.fromJson(json['ingredient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['quantity'] = quantity;
    data['unit'] = unit;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.toJson();
    }
    return data;
  }
}

class Ingredient {
  int? id;
  String? name;
  String? iconUrl = '';

  Ingredient({this.id, this.name, this.iconUrl});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['iconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    return data;
  }
}
