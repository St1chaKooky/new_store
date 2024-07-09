import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/di/di.dart';
import 'package:new_store/core/presentation/navigation_page/navigation_page.dart';
import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/account/presentation/account_page.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/feature/auth/presentation/sign_in_page.dart';
import 'package:new_store/feature/auth/presentation/splash_page.dart';
import 'package:new_store/feature/recipes/domain/repository/bloc/recipes_bloc.dart';
import 'package:new_store/feature/recipes/presentation/page/recipes_details_page.dart';
import 'package:new_store/feature/recipes/presentation/page/recipes_page.dart';
import 'package:new_store/feature/product/domain/bloc/product_bloc.dart';
import 'package:new_store/feature/product/presentation/page/product_details_page.dart';
import 'package:new_store/feature/product/presentation/page/product_page.dart';

class RouteList {
  static const _signInPath = '/signIn';
  static const signIn = _signInPath;

  static const _splashPath = '/';
  static const splash = _splashPath;

  static const _productPath = '/product';
  static const product = _productPath;

  static const _recipesPath = '/recipes';
  static const recipes = _recipesPath;

  static const _accountPath = '/account';
  static const account = _accountPath;

  static const _recipesDetailsPath = 'recipesDetails';
  static String recipesDetails(String id) =>
      '$recipes/$_recipesDetailsPath/$id';

  static const _productDetailsPath = 'productDetails';
  static String productDetails(String id) =>
      '$product/$_productDetailsPath/$id';
}

final router = GoRouter(
  initialLocation: RouteList.splash,
  routes: [
    GoRoute(
      path: RouteList._splashPath,
      builder: (context, state) => SplashPage(
        authBloc: Di().get<AuthBloc>(),
      ),
    ),
    GoRoute(
      path: RouteList._signInPath,
      builder: (context, state) => SignInPage(
        authBlock:Di().get<AuthBloc>(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        bool hasMultipleSlashes(String string) {
          final parts = string.split('/splash');
          return parts.length <= 2;
        }

        return NavigationPage(
          navigationShell: navigationShell,
          showBottomBar: !hasMultipleSlashes(state.fullPath!),
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: RouteList.product,
          routes: <RouteBase>[
            GoRoute(
              routes: [
                GoRoute(
                  path: '${RouteList._productDetailsPath}/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return ProductDetailsPage(id: id!, productBloc: Di().get<ProductBloc>(),);
                  },
                )
              ],
              path: RouteList.product,
              builder: (context, state) => ProductPage(productBloc:Di().get<ProductBloc>(),),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              routes: [
                GoRoute(
                  path: '${RouteList._recipesDetailsPath}/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return RecipesDetailsPage(id: id!, recipesBloc
                    : Di().get<RecipesBloc>(),);
                  },
                )
              ],
              path: RouteList.recipes,
              builder: (context, state) =>  RecipesPage(recipesBloc: Di().get<RecipesBloc>(),),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteList.account,
              builder: (context, state) => AccountPage(
                userBloc: Di().get<UserBloc>(),
                authBloc: Di().get<AuthBloc>(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
