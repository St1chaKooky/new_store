import 'package:json_annotation/json_annotation.dart';

part 'recipes_item_model.g.dart';

@JsonSerializable()
class RecipesItemModel {
  final int id;
  final String? name;
  final List<String>? ingredients;
  final List<String>? instructions;
  final String? image;

  RecipesItemModel({required this.name,required this.instructions, required this.ingredients,required this.image, required this.id});

  factory RecipesItemModel.fromJson(Map<String, dynamic> json) => _$RecipesItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipesItemModelToJson(this);
}