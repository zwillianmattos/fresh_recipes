// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/models/recipes/create_recipe_dto.dart';
import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/entities/photo.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/domain/services/image_service.dart';
import 'package:fresh_recipes/src/usecases/recipes/create/add_recipe.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipePageController extends Disposable {
  final CreateRecipeFormState formState = CreateRecipeFormState();
  final ValueNotifier<CreateRecipeDto?> recipeDto = ValueNotifier<CreateRecipeDto?>(null);
  final AddRecipeUseCase addRecipeUseCase;
  final ImageUploadService imageUploadService;
  CreateRecipePageController({
    required this.addRecipeUseCase,
    required this.imageUploadService,
  });
  final ImagePicker recipePhotoPicker = ImagePicker();
  @override
  void dispose() {
    formState.dispose();
  }

  onRemovePhoto() {
    formState.recipePhoto.value = null;
  }

  Future<void> onUpload(ImageSource source) async {
    final XFile? photo = await recipePhotoPicker.pickImage(source: source);
    if (photo != null) {
      formState.recipePhoto.value = photo;
    }
  }

  onIngredientSelected(Ingredients ingredient) {
    formState.ingredients.value = [
      ...formState.ingredients.value,
      ingredient
    ];
  }

  send() async {
    // Obter valores do formulário
    String title = formState.titleController.text;
    String description = formState.descriptionController.text;
    String time = formState.timeController.text;
    String difficulty = formState.difficultyController.text;
    String? calories = formState.caloriesController.text;
    String? proteins = formState.proteinsController.text;
    String? carbs = formState.carbsController.text;
    String? fats = formState.fatsController.text;

    List<Ingredients> ingredients = List.from(formState.ingredients.value);

    Photos photo = await imageUploadService.upload(formState.recipePhoto.value!.path);

    // Criar DTO
    CreateRecipeDto recipeDto = CreateRecipeDto(
      title: title,
      description: description,
      time: time,
      difficulty: difficulty,
      calories: calories,
      proteins: proteins,
      carbs: carbs,
      fats: fats,
      ingredients: ingredients,
      steps: [
        Steps(step: "Passo 1: bla bla bla")
      ],
    );
    recipeDto.photos = [
      photo.id!
    ];
    // Chamar o serviço passando o DTO
    print(recipeDto.toJson());
    var response = await addRecipeUseCase.call(recipeDto);
    print(response);
  }
}

class CreateRecipeFormState extends Disposable {
  final List<GlobalKey<FormState>> formkey = List.generate(3, (index) => GlobalKey<FormState>());
  final FormValidator formValidator = FormValidator();

  final ValueNotifier<int> currentPage = ValueNotifier<int>(0);
  final PageController stepController = PageController();
  final ValueNotifier<XFile?> recipePhoto = ValueNotifier<XFile?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();
  final TextEditingController proteinsController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatsController = TextEditingController();

  final ValueNotifier<List<Ingredients>> ingredients = ValueNotifier<List<Ingredients>>([]);

  removeIngredient(int i) {
    List<Ingredients> updatedList = List.from(ingredients.value);
    updatedList.removeAt(i);
    ingredients.value = updatedList;
  }

  onPageChanged(int page) {
    currentPage.value = page;
  }

  bool validateCurrentPage() {
    switch (currentPage.value) {
      case 0:
        return _validateStep1();
      case 1:
        return _validateStep2();
      case 2:
        return _validateStep3();
      default:
        return false;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    difficultyController.dispose();
    caloriesController.dispose();
    proteinsController.dispose();
    carbsController.dispose();
    fatsController.dispose();

    print('disposed CreateRecipeFormState');
  }

  bool _validateStep1() {
    // Adapte para os campos do passo 1
    return formValidator.validateTitle(titleController.text) == null && formValidator.validateDescription(descriptionController.text) == null;
  }

  bool _validateStep2() {
    List<Ingredients> checkIngredients = List.from(ingredients.value);
    print(checkIngredients);
    // Check hash ingredients
    return checkIngredients.isNotEmpty;
  }

  bool _validateStep3() {
    // Adapte para os campos do passo 3
    // Exemplo: return _formValidator.validateOutroCampo(yourOutroCampoController.text) == null;
    return false;
  }
}

class CreateRecipePageState {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<Recipe> dataNotifier = ValueNotifier<Recipe>(Recipe());
}

class FormValidator {
  String? validateTitle(String? value) {
    if (value == '' || value == null) {
      return 'Title is required';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == '') {
      return 'Description is required';
    }
    return null;
  }
}
