import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';

abstract class RecipesRepo {
  Future<Result<List<RecipesItemModel>>> getRecipesList(int countProduct, int countSkip);
  Future<Result<RecipesItemModel>> getRecipesItem(String id);  
}