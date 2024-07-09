
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';
import 'package:new_store/feature/recipes/domain/repository/recipes_repo.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
 final RecipesRepo recipesRepo;
  RecipesBloc({required this.recipesRepo}) : super(LoadingRecipesState()) {
    on<GetRecipesList>((event, emit) => getRecipesList(event, emit));
    on<GetRecipesItem>((event, emit) => getRecipesItem(event, emit));
  }
  void getRecipesList(GetRecipesList event, Emitter<RecipesState> emit) async {
    final newProducts = await recipesRepo.getRecipesList(countProduct, countSkip);
    countSkip += 5;
    switch (newProducts) {
      case DataResult(:final data):
        {
          if (data.isNotEmpty) {
            currentProducts.addAll(data);
            return emit(SuccesRecipesList(productList: currentProducts));
          } else {
            return emit(RecipesListIsFull(currentProductList: currentProducts));
          }
        }
      case ErrorResult(:final errorList):
        emit(ErrorRecipesList(errorMessage: errorList.join(', ')));
    }
  }

  void getRecipesItem(GetRecipesItem event, Emitter<RecipesState> emit) async {
    final recipes = await recipesRepo.getRecipesItem(event.id);
    switch (recipes) {
      case DataResult(:final data):
        emit(SuccesRecipesItem(productItem: data));
      case ErrorResult(:final errorList):
        emit(ErrorRecipesItem(errorMessage: errorList.join(', ')));
    }
  }

  final int countProduct = 5;
  int countSkip = 0;
  List<RecipesItemModel> currentProducts = [];
}
