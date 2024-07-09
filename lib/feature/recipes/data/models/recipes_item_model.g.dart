// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipesItemModel _$RecipesItemModelFromJson(Map<String, dynamic> json) =>
    RecipesItemModel(
      name: json['name'] as String?,
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      image: json['image'] as String?,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$RecipesItemModelToJson(RecipesItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'image': instance.image,
    };
