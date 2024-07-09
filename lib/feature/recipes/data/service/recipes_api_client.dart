
import 'package:dio/dio.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';
import 'package:new_store/feature/recipes/data/models/recipes_model.dart';
import 'package:retrofit/retrofit.dart';
part 'recipes_api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class RecipesApiClient {
  factory RecipesApiClient(Dio dio, {String baseUrl}) = _RecipesApiClient;
  @GET('/recipes/{id}')
  Future<RecipesItemModel> getRecipesItem(@Path('id') String id);

  @GET('recipes')
  Future<RecipesModel> getAllRecipesLimit(
    @Query('limit') int count,
    @Query('skip') int skip,
  );
}