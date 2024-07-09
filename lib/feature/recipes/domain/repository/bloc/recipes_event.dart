part of 'recipes_bloc.dart';

@immutable
abstract class RecipesEvent {}

class GetRecipesList extends RecipesEvent {}

class GetRecipesItem extends RecipesEvent {
  final String id;

  GetRecipesItem({required this.id});
} 