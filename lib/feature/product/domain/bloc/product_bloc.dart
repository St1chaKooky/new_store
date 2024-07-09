
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';
import 'package:new_store/feature/product/domain/repository/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  ProductBloc({required this.productRepo}) : super(LoadingProductState()) {
    on<GetProductList>((event, emit) => getProdutcList(event, emit));
    on<GetProductItem>((event, emit) => getProdutcItem(event, emit));
  }

  void getProdutcList(GetProductList event, Emitter<ProductState> emit) async {
    final newProducts =
        await productRepo.getProductList(countProduct, countSkip);
    countSkip += 5;
    switch (newProducts) {
      case DataResult(:final data):
        {
          if (data.isNotEmpty) {
            currentProducts.addAll(data);
            return emit(SuccesProductList(productList: currentProducts));
          } else {
            return emit(ProductListIsFull(currentProductList: currentProducts));
          }
        }
      case ErrorResult(:final errorList):
        emit(ErrorProductList(errorMessage: errorList.join(', ')));
    }
  }

  void getProdutcItem(GetProductItem event, Emitter<ProductState> emit) async {
    final product = await productRepo.getProductItem(event.id);
    switch (product) {
      case DataResult(:final data):
        emit(SuccesProductItem(productItem: data));
      case ErrorResult(:final errorList):
        emit(ErrorProductItem(errorMessage: errorList.join(', ')));
    }
  }

  final int countProduct = 5;
  int countSkip = 0;
  List<ProductItemModel> currentProducts = [];
}
