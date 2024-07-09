import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/feature/recipes/data/models/recipes_item_model.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:shimmer/shimmer.dart';

class RecipesItem extends StatelessWidget {
  final RecipesItemModel product;
  const RecipesItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(RouteList.recipesDetails(product.id.toString())),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorCollection.white),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10).copyWith(left: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            ),
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  placeholder: (context, url) => Shimmer.fromColors(
                      period: const Duration(milliseconds: 1000),
                      baseColor: ColorCollection.background,
                      highlightColor: Color.fromARGB(255, 255, 255, 255),
                      enabled: true,
                      child: Container(
                      
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorCollection.white),
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text('${product.name}', style: Theme.of(context).textTheme.titleLarge,),
              const SizedBox(
                height: 15,
              ),
               Text('Ингридиенты:', style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(
                height: 5,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return 
                       Text(product.ingredients![index]);
                    
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 2,
                      ),
                  itemCount: product.ingredients!.length)
            ],
          ),
        ),
      ),
    );
  }
}
