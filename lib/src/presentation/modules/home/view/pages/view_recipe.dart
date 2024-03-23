import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/data/helper/display_dificult.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/presentation/modules/home/view/pages/step_recipe.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState(recipe);
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool lightScreen = true;
  double recipeAmmount = 1.0;

  final Recipe? recipe;
  _RecipeDetailPageState(this.recipe);
  @override
  Widget build(BuildContext context) {
    if (recipe == null) {
      return oops(context);
    }
    return Scaffold(
      body: content(context),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StepRecipe(recipe: recipe)),
          );
        },
        label: Text(
          'Let\'s Cook',
          style: GoogleFonts.questrial(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        icon: const FaIcon(
          FontAwesomeIcons.play,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  oops(context) {
    return const Center(
      child: Text('Oops'),
    );
  }

  Widget _header(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.green,
      floating: true,
      expandedHeight: 350.0,
      stretchTriggerOffset: 50,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 2.0,
        collapseMode: CollapseMode.parallax,
        background: _buildImage(context),
      ),
      leading: Container(
        padding: const EdgeInsets.all(7),
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
          ),
          color: Colors.white,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(7),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              FontAwesomeIcons.shareNodes,
              size: 24,
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 500,
          child: Image.network(
            recipe!.photos!.first.url!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 500.0,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          recipe!.title!,
                          style: GoogleFonts.quicksand(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          recipe!.description!,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: Column(
                    children: [
                      IconButton(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.heart)),
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.comment))
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageProfile(
                        photoUrl: recipe!.chef!.account!.profilePhoto!,
                        width: 42,
                        height: 42,
                        borderRadius: 50.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        recipe!.chef!.account!.name!,
                        style: GoogleFonts.questrial(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2.0, color: Colors.green),
                    ),
                    child: Text(
                      "+ Follow",
                      style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RecipeInfoCard(
                recipeTime: recipe!.time!,
                recipeCalories: recipe!.calories!,
                recipeLevel: displayDificult(recipe!.difficulty!),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundInforCard(
                    text: recipe!.proteins!,
                    desc: 'Proteins',
                    textStyle: GoogleFonts.quicksand(),
                  ),
                  RoundInforCard(
                    text: recipe!.carbs!,
                    desc: 'Carbs',
                    textStyle: GoogleFonts.quicksand(),
                  ),
                  RoundInforCard(
                    text: recipe!.fats!,
                    desc: 'Fats',
                    textStyle: GoogleFonts.quicksand(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 5.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ingredients",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (recipeAmmount == 1) {
                              recipeAmmount = 0.5;
                            } else if (recipeAmmount == 0.5) {
                              recipeAmmount = 0.5;
                            } else {
                              recipeAmmount--;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          shadowColor: Colors.transparent,
                        ),
                        child: const FaIcon(FontAwesomeIcons.minus),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            convertToFraction(recipeAmmount),
                            style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.bowlRice,
                            size: 16,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (recipeAmmount == 0.5) {
                              recipeAmmount = 1;
                            } else {
                              recipeAmmount++;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(5),
                          shadowColor: Colors.transparent,
                        ),
                        child: const FaIcon(FontAwesomeIcons.plus),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe!.ingredients != null)
                    ...recipe!.ingredients!.map(
                      (Ingredients e) => ListTile(
                        minVerticalPadding: 1.0,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                        title: Text(
                          e.ingredient!.name!,
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        trailing: Text(
                          displayRecipe(e),
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const FaIcon(FontAwesomeIcons.sun),
                      Text(
                        "Don't turn off screen while cooking",
                        style: GoogleFonts.quicksand(),
                      ),
                      Switch(
                        value: lightScreen,
                        onChanged: (bool value) {
                          setState(() {
                            lightScreen = value;
                          });
                        },
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 5.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Made it? Share with others",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          _header(context)
        ];
      },
      body: _body(context),
    );
  }

  String displayRecipe(
    Ingredients data,
  ) {
    num originalQuantity = data.quantity!;
    String unit = data.unit!;
    String quantityDisplay = convertToFraction(originalQuantity * recipeAmmount);
    return "$quantityDisplay $unit";
  }

  String convertToFraction(num value) {
    if (value % 1 == 0) {
      return value.toInt() > 0 ? value.toInt().toString() : '';
    } else {
      int denominator = 1000000;
      int numerator = (value * denominator).round();
      int gcd = _gcd(numerator, denominator);
      numerator ~/= gcd;
      denominator ~/= gcd;
      return '$numerator/$denominator';
    }
  }

  int _gcd(int a, int b) {
    while (b != 0) {
      int remainder = a % b;
      a = b;
      b = remainder;
    }
    return a.abs();
  }
}
