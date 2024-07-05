part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class GetProductList extends ProductEvent {}

class GetProductItem extends ProductEvent {
  final String id;

  GetProductItem({required this.id});
} 

