import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:google_fonts/google_fonts.dart';

class StepRecipe extends StatefulWidget {
  final Recipe? recipe;
  const StepRecipe({super.key, this.recipe});

  @override
  State<StepRecipe> createState() => _RecipeState();
}

class _RecipeState extends State<StepRecipe> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Widget>>? getItems() {
    List<Widget> items = [];
    for (Steps step in widget.recipe!.steps!) {
      Widget item;
      if (step.photo != null && step.photo != '') {
        item = Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  step.photo!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250.0,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              step.step!,
              style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.normal),
            )
          ],
        );
      } else {
        item = Container(
          height: 250.0,
          padding: const EdgeInsets.all(10.0),
          child: Text(
            step.step!,
            style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        );
      }

      items.add(item);
    }
    return Future.delayed(Duration.zero).then((value) => items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.recipe?.title}"),
      ),
      body: FutureBuilder<List<Widget>>(
          future: getItems(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('err'),
              );
            }
            return SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                CarouselSlider(
                  items: snapshot.data,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {},
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                ),
              ]),
            );
          }),
    );
  }
}
