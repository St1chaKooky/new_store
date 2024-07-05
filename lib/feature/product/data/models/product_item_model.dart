import 'package:json_annotation/json_annotation.dart';

part 'product_item_model.g.dart';

@JsonSerializable()
class ProductItemModel {
  final int id;
  final String? title;
  final String? brand;
  final double? price;
  final String? category;
  final List<String>? images;
  final String? thumbnail;

  final String? description;

  ProductItemModel({required this.description, required this.thumbnail, required this.brand,required this.title,required this.price,required this.category, required this.images, required this.id});

  factory ProductItemModel.fromJson(Map<String, dynamic> json) => _$ProductItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemModelToJson(this);
}