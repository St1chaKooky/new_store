part of 'product_bloc.dart';

class ProductState {}

class LoadingProductState extends ProductState {}

class SuccesProductList extends ProductState {
  final List<ProductItemModel> productList;

  SuccesProductList({required this.productList});
}

class SuccesProductItem extends ProductState {
  final ProductItemModel productItem;

  SuccesProductItem({required this.productItem});
}

class ErrorProductList extends ProductState {
  final String errorMessage;

  ErrorProductList({required this.errorMessage});
  
}

class ErrorProductItem extends ProductState {
  final String errorMessage;

  ErrorProductItem({required this.errorMessage});
}


class ProductListIsFull extends ProductState{
   final List<ProductItemModel> currentProductList;

  ProductListIsFull({required this.currentProductList});
}