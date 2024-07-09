import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_store/core/domain/repository/token_interceptor.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/account/data/repository/user_repo_impl.dart';
import 'package:new_store/feature/account/data/service/user_api_client.dart';
import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/account/domain/repository/user_repo.dart';
import 'package:new_store/feature/auth/data/repository/auth_repo_impl.dart';
import 'package:new_store/feature/auth/data/service/auth_api_client.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';
import 'package:new_store/feature/product/data/repository/product_repo_impl.dart';
import 'package:new_store/feature/product/data/service/product_api_client.dart';
import 'package:new_store/feature/product/domain/bloc/product_bloc.dart';
import 'package:new_store/feature/product/domain/repository/product_repo.dart';
import 'package:new_store/feature/recipes/data/repository/recipes_repo_impl.dart';
import 'package:new_store/feature/recipes/data/service/recipes_api_client.dart';
import 'package:new_store/feature/recipes/domain/repository/bloc/recipes_bloc.dart';
import 'package:new_store/feature/recipes/domain/repository/recipes_repo.dart';
import 'package:reg_it_abstract/reg_it_abstract.dart';

class Di implements Registry {
  static final instance = Di._();
  Di._();
  factory Di() => instance;
  //Обьявлем здесь скоупы
  //Скоуп для стейтМенеджера в нашем случае block
  //Скоуп для моков репозиториев которые мы прокидываем в наш блок.
  //Они являются типом родительского класса. final Repo repo = RepoMocked;

  //иницилизируем зависимости нашего DI контейнера
  Future<void> initDependencies() async {
    try {
      final SecureRepo secureRepo = SecureRepo();
      put(SingletonRegistrar(secureRepo));
      final authDio = Dio();
      final AuthApiClient authApiClient = AuthApiClient(authDio);
      final AuthRepo authRepo = AuthRepoImpl(authApiClient, secureRepo);
      put(SingletonRegistrar(authRepo));

      //обьявляем highСкопы
      final Dio dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(TokenInterceptor(secureRepo, authRepo, authDio));
      final ProductApiClient productApiClient = ProductApiClient(dio);
      final UserApiClient userApiClient = UserApiClient(dio);
      final RecipesApiClient recipesApiClient = RecipesApiClient(dio);
      //обьявляем скопы репозиториев
      final RecipesRepo recipesRepo = RecipesRepoImpl(recipesApiClient: recipesApiClient);
      final ProductRepo productRepo = ProductRepoImpl(productApiClient: productApiClient);
      final UserRepo userhRepo = UserRepoImpl(userApiClient, secureRepo);
      put(SingletonRegistrar(productRepo));
      put(SingletonRegistrar(userhRepo));
      put(SingletonRegistrar(recipesRepo));

      //обьявляем скопы стейт менеджера
      final recipesBloc = RecipesBloc(recipesRepo: recipesRepo);
      final productBloc = ProductBloc(productRepo: productRepo);
      final userBlock = UserBloc(repo: userhRepo);
      final authBlock = AuthBloc(
          authRepo: authRepo, secureRepo: secureRepo, goRouter: router);
      put(SingletonRegistrar(productBloc));
      put(SingletonRegistrar(userBlock));
      put(SingletonRegistrar(authBlock));
      put(SingletonRegistrar(recipesBloc));

    } catch (e, st) {
      log('App Container has not been initialized', error: e, stackTrace: st);
    }
  }

  @override
  void drop<T>() {
    final droppingInstance = GetIt.instance<Registrar<T>>();
    droppingInstance.dispose();
    GetIt.instance.unregister<Registrar<T>>();
  }

  @override
  T get<T>() => GetIt.instance.get<Registrar<T>>().instance;

  @override
  void put<T>(Registrar<T> registrar) =>
      GetIt.instance.registerSingleton<Registrar<T>>(registrar);

  bool isExists<T>() => GetIt.instance.isRegistered<Registrar<T>>();
}
