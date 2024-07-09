import 'package:dio/dio.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';
import 'package:new_store/feature/recipes/data/service/recipes_api_client.dart';

import 'package:new_store/feature/recipes/domain/repository/recipes_repo.dart';

class RecipesRepoImpl implements RecipesRepo {
  final RecipesApiClient _recipesApiClient;

  RecipesRepoImpl({required RecipesApiClient recipesApiClient})
      : _recipesApiClient = recipesApiClient;
  @override
  Future<Result<List<RecipesItemModel>>> getRecipesList(int countProduct, int countSkip) async {
    try {
      final recipesResponse = await _recipesApiClient.getAllRecipesLimit(countProduct,countSkip);
      final recipesList = recipesResponse.recipes;
      return DataResult(recipesList);
    } on DioException catch (error) {
      
      if (error.response != null){
          return ErrorResult([error.response!.data.toString()]);
        } else {
          return ErrorResult([error.message.toString()]);
        }  
    }
  }
  
  @override
  Future<Result<RecipesItemModel>> getRecipesItem(String id) async {
    try {
      final recipes = await _recipesApiClient.getRecipesItem(id);
      return DataResult(recipes);
    } on DioException catch (error) {
      if (error.response != null){
          return ErrorResult([error.response!.data.toString()]);
        } else {
          return ErrorResult([error.message.toString()]);
        }  
    }
  }
}
