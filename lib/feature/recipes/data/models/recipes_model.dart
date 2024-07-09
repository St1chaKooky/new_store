import 'package:json_annotation/json_annotation.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';

part 'recipes_model.g.dart';
@JsonSerializable()
class RecipesModel {
  final List<RecipesItemModel> recipes;
  final int total;
  final int skip;
  final int limit;

  RecipesModel({required this.recipes, required this.total, required this.skip, required this.limit});
  factory RecipesModel.fromJson(Map<String, dynamic> json) => _$RecipesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipesModelToJson(this);

}