import 'package:json_annotation/json_annotation.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';


part 'product_model.g.dart';
@JsonSerializable()
class ProductModel {
  final List<ProductItemModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductModel({required this.products, required this.total, required this.skip, required this.limit});
  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

}