import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/ingredients/ingredients_search_controller.dart';

class IngredientsSearchPage extends StatefulWidget {
  final Function(Ingredients) onIngredientSelected;
  const IngredientsSearchPage({Key? key, required this.onIngredientSelected}) : super(key: key);

  @override
  State<IngredientsSearchPage> createState() => _IngredientsSearchPageState();
}

class _IngredientsSearchPageState extends State<IngredientsSearchPage> {
  final IngredientsSearchPageController controller = IngredientsSearchPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Igredient'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.ingredients,
          builder: (context, ingredients, child) {
            List<Widget> result = [];

            if (ingredients.isNotEmpty) {
              for (var ingredient in ingredients) {
                result.add(ListTile(
                  title: Text('${ingredient.name}'),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('${ingredient.name}'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: controller.quantityController,
                                  decoration: const InputDecoration(hintText: "Qtd"),
                                ),
                                TextField(
                                  controller: controller.unitController,
                                  decoration: const InputDecoration(hintText: "Unit"),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  setState(() {
                                    int qtd = int.parse(controller.quantityController.text);
                                    Ingredients newIngredient = Ingredients(quantity: qtd, unit: controller.unitController.text, ingredient: ingredient);
                                    widget.onIngredientSelected(newIngredient);
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  },
                ));
              }
            } else {
              result.add(const Center(
                child: CircularProgressIndicator(),
              ));
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FreshTextField(
                    hintText: 'Search',
                    controller: controller.searchController,
                    onChanged: (String value) {
                      controller.doSearch();
                    },
                    prefixIcon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 16,
                    ),
                  ),
                  ...result,
                ],
              ),
            );
          }),
    );
  }
}
