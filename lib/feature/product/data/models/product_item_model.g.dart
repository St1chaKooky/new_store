// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItemModel _$ProductItemModelFromJson(Map<String, dynamic> json) =>
    ProductItemModel(
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
      brand: json['brand'] as String?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$ProductItemModelToJson(ProductItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'brand': instance.brand,
      'price': instance.price,
      'category': instance.category,
      'images': instance.images,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
    };
