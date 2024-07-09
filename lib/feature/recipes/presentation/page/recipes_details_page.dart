import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/feature/recipes/domain/repository/bloc/recipes_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';
import 'package:shimmer/shimmer.dart';

class RecipesDetailsPage extends StatefulWidget {
  final RecipesBloc _recipesBloc;
  final String id;
  const RecipesDetailsPage(
      {super.key, required this.id, required RecipesBloc recipesBloc})
      : _recipesBloc = recipesBloc;

  @override
  State<RecipesDetailsPage> createState() => _RecipesDetailsPageState();
}

class _RecipesDetailsPageState extends State<RecipesDetailsPage> {
  RecipesBloc get recipesBloc => widget._recipesBloc;
  String get id => widget.id;

  @override
  void initState() {
    recipesBloc.add(GetRecipesItem(id: id));
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
                  recipesBloc.add(GetRecipesList());
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
          'Выбранный рецепт',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<RecipesBloc, RecipesState>(
          bloc: recipesBloc,
          builder: (context, state) {
            return switch (state) {
              SuccesRecipesItem(:final productItem) => SingleChildScrollView(
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
                        child: Center(
                            child: CachedNetworkImage(
                                imageUrl: productItem.image!,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                        period:
                                            const Duration(milliseconds: 1000),
                                        baseColor: ColorCollection.background,
                                        highlightColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        enabled: true,
                                        child: Container(
                                          height:
                                              MediaQuery.sizeOf(context).height,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: ColorCollection.white),
                                        )))),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${productItem.name}',
                        style: Theme.of(context).textTheme.titleLarge,
                        softWrap: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Ингридиенты',
                        style: Theme.of(context).textTheme.titleMedium,
                        softWrap: true,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(productItem.ingredients![index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 2,
                              ),
                          itemCount: productItem.ingredients!.length),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Как готовить?',
                        style: Theme.of(context).textTheme.titleMedium,
                        softWrap: true,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(productItem.instructions![index]);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 2,
                              ),
                          itemCount: productItem.instructions!.length),
                    ],
                  ),
                ),
              LoadingRecipesState() => const Center(
                    child: CircularProgressIndicator(
                  color: ColorCollection.primary,
                )),
              RecipesState() => const Center(
                    child: CircularProgressIndicator(
                  color: ColorCollection.primary,
                )),
            };
          }),
    );
  }
}
