part of 'recipes_bloc.dart';

@immutable
abstract class RecipesState {}

class LoadingRecipesState extends RecipesState {}

class SuccesRecipesList extends RecipesState {
  final List<RecipesItemModel> productList;

  SuccesRecipesList({required this.productList});
}

class SuccesRecipesItem extends RecipesState {
  final RecipesItemModel productItem;

  SuccesRecipesItem({required this.productItem});
}

class ErrorRecipesList extends RecipesState {
  final String errorMessage;

  ErrorRecipesList({required this.errorMessage});
  
}

class ErrorRecipesItem extends RecipesState {
  final String errorMessage;

  ErrorRecipesItem({required this.errorMessage});
}


class RecipesListIsFull extends RecipesState{
   final List<RecipesItemModel> currentProductList;

  RecipesListIsFull({required this.currentProductList});
}
