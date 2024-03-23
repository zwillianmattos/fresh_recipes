import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';

class RecipeInfoCard extends StatefulWidget {
  final String recipeCalories;
  final String recipeTime;
  final String recipeLevel;

  const RecipeInfoCard({
    super.key,
    required this.recipeCalories,
    required this.recipeTime,
    required this.recipeLevel,
  });

  @override
  State<RecipeInfoCard> createState() => _RecipeInfoCardState();
}

class _RecipeInfoCardState extends State<RecipeInfoCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        color: Colors.white,
        elevation: 0.2,
        shadowColor: Colors.grey,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FaIcon(FontAwesomeIcons.clock),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.recipeTime),
                  ],
                ),
              ),
              const SizedBox(height: 15, child: VerticalDivider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FaIcon(FontAwesomeIcons.flag),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.recipeLevel),
                  ],
                ),
              ),
              const SizedBox(height: 15, child: VerticalDivider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const FaIcon(FontAwesomeIcons.calculator),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.recipeCalories),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final String photoUrl;
  final String title;
  final String description;

  final String profilePhoto;
  final String proileName;

  final String recipeCalories;
  final String recipeTime;
  final String recipeLevel;

  final Function()? callback;

  const RecipeCard({
    super.key,
    required this.photoUrl,
    required this.title,
    required this.description,
    required this.profilePhoto,
    required this.proileName,
    required this.recipeCalories,
    required this.recipeTime,
    required this.recipeLevel,
    required this.callback,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          InkWell(
            onTap: widget.callback,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Stack(
                  children: [
                    ...createImage(),
                    creaetInfoTop(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: RecipeInfoCard(
              recipeCalories: widget.recipeCalories,
              recipeTime: widget.recipeTime,
              recipeLevel: widget.recipeLevel,
            ),
          ),
        ],
      ),
    );
  }

  createImage() {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: CachedNetworkImage(
          imageUrl: widget.photoUrl,
          fit: BoxFit.cover,
          height: 250.0,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      Container(
        height: 250.0,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Colors.black,
              Colors.transparent,
            ],
          ),
        ),
      ),
      Positioned(
        bottom: 45.0,
        left: 15.0,
        right: 15.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  createInfoChef() {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            child: ImageProfile(
              photoUrl: widget.profilePhoto,
              width: 24,
              height: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(widget.proileName),
          )
        ],
      ),
    );
  }

  creaetInfoTop() {
    return Positioned(
      top: 10,
      left: 15,
      right: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          createInfoChef(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.heart),
              color: Colors.white,
              iconSize: 18,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
