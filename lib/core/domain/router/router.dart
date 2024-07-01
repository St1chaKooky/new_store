import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/di/di.dart';
import 'package:new_store/core/presentation/navigation_page/navigation_page.dart';
import 'package:new_store/feature/account/presentation/account_page.dart';
import 'package:new_store/feature/auth/presentation/sign_in_page.dart';
import 'package:new_store/feature/cart/presentation/cart_page.dart';
import 'package:new_store/feature/splash/presentation/splash_page.dart';

class RouteList {
  static const _signInPath = '/signIn';
  static const signIn = _signInPath;

  static const _splashPath = '/';
  static const splash = _splashPath;

  // static const _productPath = '/product';
  // static const product = _productPath;

  static const _cartPath = '/cart';
  static const cart = _cartPath;

  static const _accountPath = '/account';
  static const account = _accountPath;

  // static const _editPath = 'edit';
  // static String edit() => '$_accountPath/$_editPath';

  // static const _productDetailsPath = 'productDetails';
  // static String productDetails(String id) =>
  //     '$product/$_productDetailsPath/$id';
}

final router = GoRouter(
  initialLocation: RouteList.splash,
  routes: [
    GoRoute(
      path: RouteList._splashPath,
      builder: (context, state) =>  SplashPage(checkBloc: Di().blockScope.checkBloc,),
    ),
    GoRoute(
      path: RouteList._signInPath,
      builder: (context, state) =>  SignInPage(authBlock: Di().blockScope.authBlock,),
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
        // StatefulShellBranch(
        //   initialLocation: RouteList.product,
        //   routes: <RouteBase>[
        //     GoRoute(
        //       routes: [
        //         GoRoute(
        //           path: '${RouteList._productDetailsPath}/:id',
        //           builder: (context, state) {
        //             final id = state.pathParameters['id'];
        //             return ProductDetails(id: id!);
        //           },
        //         )
        //       ],
        //       path: RouteList.product,
        //       builder: (context, state) => const ProductsListPage(),
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteList.cart,
              builder: (context, state) => CartPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: RouteList.account,
              builder: (context, state) => AccountPage(userBloc: Di().blockScope.userBloc,),
            ),
          ],
        ),
      ],
    ),
  ],
);
