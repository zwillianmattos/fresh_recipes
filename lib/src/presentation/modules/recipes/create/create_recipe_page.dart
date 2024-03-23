import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/create/create_recipe_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/recipes/ingredients/ingredients_search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../../../../data/helper/display_dificult.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final CreateRecipePageController controller = Modular.get<CreateRecipePageController>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.formState.currentPage,
      builder: (BuildContext context, int currentPage, Widget? child) {
        return Scaffold(
          floatingActionButton: (currentPage == 1)
              ? FloatingActionButton.extended(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      useSafeArea: false,
                      builder: (BuildContext context) {
                        return IngredientsSearchPage(
                          onIngredientSelected: controller.onIngredientSelected,
                        );
                      },
                    );
                  },
                  label: Text(
                    'Ingredient',
                    style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus),
                )
              : Container(),
          body: Container(
            padding: const EdgeInsets.only(top: 64.0),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.formState.stepController,
              onPageChanged: controller.formState.onPageChanged,
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage == 0)
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      controller.dispose();
                      Navigator.pop(context);
                    },
                  ),
                if (currentPage > 0)
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      controller.formState.stepController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                if (currentPage < 2)
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      if (controller.formState.formkey[currentPage].currentState!.validate()) {
                        controller.formState.stepController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                if (currentPage == 2)
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidFloppyDisk,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      await controller.send();
                      if (context.mounted) {
                        Navigator.pop(context);
                        toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.fillColored,
                          title: 'Recipe Successfuly created',
                          alignment: Alignment.bottomCenter,
                          autoCloseDuration: const Duration(seconds: 4),
                          borderRadius: BorderRadius.circular(100.0),
                          boxShadow: lowModeShadow,
                        );
                      }
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep1() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formState.formkey[0],
        child: Column(
          children: [
            const Text('Step 1'),
            _selectPhoto(),
            FreshTextField(
              hintText: 'Title',
              controller: controller.formState.titleController,
              validator: controller.formState.formValidator.validateTitle,
            ),
            FreshTextField(
              hintText: 'Description',
              controller: controller.formState.descriptionController,
              validator: controller.formState.formValidator.validateDescription,
              maxLines: 5,
            ),
            FreshTextField(
              onTap: () {
                _showDialog(
                  TempoPreparoPicker(
                    onTempoPreparoChanged: (DateTime value) {
                      controller.formState.timeController.text = formatarTempoEmMinutos(value);
                    },
                  ),
                  title: 'Cooking Time',
                );
              },
              readOnly: true,
              hintText: 'Time',
              controller: controller.formState.timeController,
            ),
            FreshTextField(
              onTap: () {
                _showDialog(
                  DificultPicker(cb: (int value) {
                    controller.formState.difficultyController.text = displayDificult(value.toString());
                  }),
                  title: 'Change Difficult',
                );
              },
              readOnly: true,
              hintText: 'Difficult',
              controller: controller.formState.difficultyController,
            ),
            FreshTextField(
              hintText: 'Calories',
              controller: controller.formState.caloriesController,
            ),
            FreshTextField(
              hintText: 'Proteins',
              controller: controller.formState.proteinsController,
            ),
            FreshTextField(
              hintText: 'Carbs',
              controller: controller.formState.carbsController,
            ),
            FreshTextField(
              hintText: 'Fats',
              controller: controller.formState.fatsController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectPhoto() {
    return ValueListenableBuilder<XFile?>(
        valueListenable: controller.formState.recipePhoto,
        builder: (context, image, child) {
          return InkWell(
            onTap: () {
              _showDialog(Column(
                children: [
                  ListTile(
                    title: const Text('Photo Galery'),
                    onTap: () {
                      controller.onUpload(ImageSource.gallery).then((value) => Navigator.pop(context, true));
                    },
                  ),
                  ListTile(
                    title: const Text('Camera'),
                    onTap: () {
                      controller.onUpload(ImageSource.camera).then((value) => Navigator.pop(context, true));
                    },
                  ),
                  if (image?.path != null)
                    ListTile(
                      title: const Text('Remove Photo'),
                      onTap: () {
                        controller.onRemovePhoto();
                        Navigator.pop(context);
                      },
                    ),
                ],
              ));
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 250,
              width: MediaQuery.sizeOf(context).width,
              child: image == null
                  ? const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(FontAwesomeIcons.image),
                      SizedBox(height: 10),
                      Text("Tap to upload photo"),
                    ])
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          );
        });
  }

  Widget _buildStep2() {
    return Form(
      key: controller.formState.formkey[1],
      child: ValueListenableBuilder(
        valueListenable: controller.formState.ingredients,
        builder: (BuildContext context, List<Ingredients> ingredient, Widget? child) {
          return ListView.builder(
            itemBuilder: (_, i) {
              return ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  '${ingredient[i].ingredient!.name}',
                  style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${ingredient[i].quantity} ${ingredient[i].unit}',
                  style: GoogleFonts.quicksand(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () => controller.formState.removeIngredient(i),
                  icon: const Icon(
                    FontAwesomeIcons.trash,
                    size: 16,
                  ),
                ),
              );
            },
            itemCount: ingredient.length,
          );
        },
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formState.formkey[2],
        child: const Column(
          children: [
            Text('Step 3'),
          ],
        ),
      ),
    );
  }

  void _showDialog(Widget child, {String? title, double? size}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) => Container(
        height: size ?? 300,
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            Expanded(child: child),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    'Done',
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DificultPicker extends StatefulWidget {
  final ValueChanged<int> cb;
  const DificultPicker({super.key, required this.cb});

  @override
  State<DificultPicker> createState() => _DificultPickerState();
}

class _DificultPickerState extends State<DificultPicker> {
  int option = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Easy'),
          onTap: () => _changeOption(1),
        ),
        ListTile(
          title: const Text('Medium'),
          onTap: () => _changeOption(2),
        ),
        ListTile(
          title: const Text('Hard'),
          onTap: () => _changeOption(3),
        ),
      ],
    );
  }

  _changeOption(int value) {
    widget.cb(value);
  }
}

class TempoPreparoPicker extends StatefulWidget {
  final ValueChanged<DateTime> onTempoPreparoChanged;

  const TempoPreparoPicker({super.key, required this.onTempoPreparoChanged});

  @override
  TempoPreparoPickerState createState() => TempoPreparoPickerState();
}

class TempoPreparoPickerState extends State<TempoPreparoPicker> {
  DateTime time = DateTime(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return CupertinoDatePicker(
      initialDateTime: time,
      mode: CupertinoDatePickerMode.time,
      minuteInterval: 5,
      use24hFormat: true,
      onDateTimeChanged: (DateTime newTime) {
        setState(() => time = newTime);
        widget.onTempoPreparoChanged(newTime);
      },
    );
  }
}
