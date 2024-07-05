import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () =>
          context.push(RouteList.productDetails(product.id.toString())),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorCollection.white),
        width: double.infinity,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10).copyWith(left: 0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(9),
                width: width / 2.24,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: product.images![0],
                    placeholder: (context, url) => 
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1000),
                          baseColor: ColorCollection.background,
                          highlightColor: Color.fromARGB(255, 255, 255, 255),
                          enabled: true,
                          child: Container(height: 150,width: 150,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorCollection.white
                          ),)),
                    
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Категория: ${product.category}',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Читать дальше'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Цена: ${product.price}\$',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
