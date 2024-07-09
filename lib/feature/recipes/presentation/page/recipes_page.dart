import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_store/feature/recipes/domain/repository/bloc/recipes_bloc.dart';
import 'package:new_store/feature/recipes/presentation/widget/recipes_item.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class RecipesPage extends StatefulWidget {
  final RecipesBloc _recipesBloc;
  const RecipesPage({super.key, required RecipesBloc recipesBloc}): _recipesBloc = recipesBloc;

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  RecipesBloc get recipesBloc => widget._recipesBloc;
  final controller = ScrollController();
  @override
  void initState() {
    recipesBloc.add(GetRecipesList());
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        recipesBloc.add(GetRecipesList());
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
          'Список Рецептов:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<RecipesBloc, RecipesState>(
          bloc: recipesBloc,
          builder: (context, state) {
            return switch (state) {
              LoadingRecipesState() => const Center(
                  child: CircularProgressIndicator(
                    color: ColorCollection.primary,
                  ),
                ),
              SuccesRecipesList(:final productList) =>
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  controller: controller,
                  separatorBuilder:
                      (BuildContext context, int index) =>
                          const SizedBox(
                    height: 10,
                  ),
                  // physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < productList.length) {
                      return RecipesItem(
                        product: productList[index],
                      );
                    } else {
                      if (state is RecipesListIsFull){
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
              // TODO: Handle this case.
              RecipesState() => Container(),
            };
          }),
    );
  }
}