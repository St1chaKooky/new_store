import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_store/feature/product/domain/bloc/product_bloc.dart';
import 'package:new_store/feature/product/presentation/widget/product_item.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class ProductPage extends StatefulWidget {
  final ProductBloc _productBloc;
  const ProductPage({super.key, required ProductBloc productBloc})
      : _productBloc = productBloc;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final controller = ScrollController();

  ProductBloc get productBloc => widget._productBloc;
  @override
  void initState() {
    productBloc.add(GetProductList());
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        productBloc.add(GetProductList());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCollection.background,
        excludeHeaderSemantics: false,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Список товара:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
          bloc: productBloc,
          builder: (context, state) {
            return switch (state) {
              LoadingProductState() => const Center(
                  child: CircularProgressIndicator(
                    color: ColorCollection.primary,
                  ),
                ),
              SuccesProductList(:final productList) =>
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  controller: controller,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.separated(
                          separatorBuilder:
                              (BuildContext context, int index) =>
                                  const SizedBox(
                            height: 10,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < productList.length) {
                              return ProductItem(
                                product: productList[index],
                              );
                            } else {
                              if (state is ProductListIsFull){
                                return Center(child: Text('Вы получили весь список'),);
                              }
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircularProgressIndicator(
                                    color: ColorCollection.primary,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }
                          },
                          itemCount: productList.length + 1,
                        ),
                      ]),
                ),
              // TODO: Handle this case.
              ProductState() => Container(),
            };
          }),
    );
  }
}
