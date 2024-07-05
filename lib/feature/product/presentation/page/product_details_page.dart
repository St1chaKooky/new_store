import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/feature/product/domain/bloc/product_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductBloc _productBloc;
  final String id;
  const ProductDetailsPage(
      {super.key, required this.id, required ProductBloc productBloc})
      : _productBloc = productBloc;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductBloc get productBloc => widget._productBloc;
  String get id => widget.id;

  @override
  void initState() {
    productBloc.add(GetProductItem(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_shopping_cart_sharp,
                  color: ColorCollection.text))
        ],
        leading: context.canPop()
            ? IconButton(
                onPressed: () {
                  productBloc.add(GetProductList());
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: ColorCollection.text,
                ))
            : const SizedBox.shrink(),
        backgroundColor: ColorCollection.background,
        excludeHeaderSemantics: false,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Выбранный продукт',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body:  BlocBuilder<ProductBloc, ProductState>(
          bloc: productBloc,
          builder: (context, state) {
            return switch (state) {
              SuccesProductItem(:final productItem) => SingleChildScrollView(
      padding: EdgeInsets.all(16),
      
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorCollection.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(9),
                        width: double.infinity,
                        height: 250,
                        child: Center(
                          child: CachedNetworkImage(
                    imageUrl: productItem.images![0],
                    placeholder: (context, url) => 
                      Shimmer.fromColors(
                        period: const Duration(milliseconds: 1000),
                          baseColor: ColorCollection.background,
                          highlightColor: Color.fromARGB(255, 255, 255, 255),
                          enabled: true,
                          child: Container(height: MediaQuery.sizeOf(context).height,width:    MediaQuery.sizeOf(context).width
,decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorCollection.white
                          ),)))
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${productItem.title}',
                        style: Theme.of(context).textTheme.titleLarge,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Цена: ${productItem.price}\$',
                        style: Theme.of(context).textTheme.titleLarge,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                  
                      Text('${productItem.description}'),
                    ],
                  ),
              ),
              LoadingProductState() =>const Center(child: CircularProgressIndicator(color: ColorCollection.primary,)),
              ProductState() => const Center(child: CircularProgressIndicator(color: ColorCollection.primary,)),
            };
          }),
    );
  }
}
