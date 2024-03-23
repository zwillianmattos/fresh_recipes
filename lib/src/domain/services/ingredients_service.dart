import 'package:fresh_recipes/src/domain/entities/ingredient.dart';
import 'package:fresh_recipes/src/domain/services/base_service.dart';

abstract class IngredientsService implements BaseService {
  IngredientsService();

  Future<List<Ingredient>> get({String? query});
}
