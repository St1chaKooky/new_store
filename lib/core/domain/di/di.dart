import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_store/core/domain/di/block_scope_di.dart';
import 'package:new_store/core/domain/di/params_scope.dart';
import 'package:new_store/core/domain/di/repository_scope_di.dart';
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

class Di {
  //Обьявлем здесь скоупы
  //Скоуп для стейтМенеджера в нашем случае block
  //Скоуп для моков репозиториев которые мы прокидываем в наш блок.
  //Они являются типом родительского класса. final Repo repo = RepoMocked;
  late final BlocksScope blockScope;
  late final RepositoryScope repositoryScope;
  late final ParamsScope paramsScope;

  late final Future<bool> ready;

  //Иминованный конструктор через который мы иницилизируем нашу DI вместо того
  //чтобы иницилизировать DI в мейне
  Di.init() {
    ready = initDependencies();
    //регистрирует сингл тон, жизненый цикл которого один раз производится
    GetIt.instance.registerSingleton(this);
  }

  //иницилизируем
  factory Di() => GetIt.instance<Di>();

  //иницилизируем зависимости нашего DI контейнера
  Future<bool> initDependencies() async {
    try {
      final SecureRepo secureRepo = SecureRepo();

      final authDio = Dio();
      final AuthApiClient authApiClient = AuthApiClient(authDio);
      final AuthRepo authRepo = AuthRepoImpl(authApiClient, secureRepo);

      //обьявляем highСкопы
      final Dio dio = Dio();
      dio.interceptors.clear();
      dio.interceptors.add(TokenInterceptor(secureRepo, authRepo, authDio));
      final ProductApiClient productApiClient = ProductApiClient(dio);
      final UserApiClient userApiClient = UserApiClient(dio);
      //обьявляем скопы репозиториев
      final ProductRepo productRepo = ProductRepoImpl(productApiClient: productApiClient);
      final UserRepo userhRepo = UserRepoImpl(userApiClient, secureRepo);
      repositoryScope =
          RepositoryScope(authRepo: authRepo, userhRepo: userhRepo, productRepo: productRepo);

      //обьявляем скопы стейт менеджера
      final productBloc = ProductBloc(productRepo: productRepo);
      final userBlock = UserBloc(repo: repositoryScope.userhRepo);
      final authBlock = AuthBloc(
          authRepo: repositoryScope.authRepo,
          secureRepo: secureRepo,
          goRouter: router);
      blockScope = BlocksScope(
        productBloc: productBloc,
        authBlock: authBlock,
        userBloc: userBlock,
      );
      //Иницилизированные параметры

      return true;
    } catch (e, st) {
      log('App Container has not been initialized', error: e, stackTrace: st);
      return false;
    }
  }
}
