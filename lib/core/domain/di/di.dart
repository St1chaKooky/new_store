import 'dart:developer';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_store/core/domain/di/block_scope_di.dart';
import 'package:new_store/core/domain/di/params_scope.dart';
import 'package:new_store/core/domain/di/repository_scope_di.dart';
import 'package:new_store/core/domain/repository/dio_interceptor.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/account/data/repository/user_mocked_repo.dart';
import 'package:new_store/feature/account/data/service/user_api_client.dart';
import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/account/domain/repository/user_repo.dart';
import 'package:new_store/feature/auth/data/repository/auth_mocked_repo.dart';
import 'package:new_store/feature/auth/data/service/auth_api_client.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';
import 'package:new_store/feature/splash/domain/bloc/check_bloc.dart';

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
      
      //обьявляем highСкопы
      final Dio dio = Dio();
      final SecureRepo secureRepo = SecureRepo();
      final AuthApiClient authApiClient = AuthApiClient(dio);
      final UserApiClient userApiClient = UserApiClient(dio);
      //обьявляем скопы репозиториев
      final AuthRepo authRepo = AuthMockedRepo(authApiClient, secureRepo);
      final UserRepo userhRepo = UserMockedRepo(userApiClient, secureRepo);
      repositoryScope = RepositoryScope(authRepo: authRepo, userhRepo: userhRepo);

      final token = await secureRepo.readValue('token');
      token != null ? dio.interceptors.add(DioInterceptor(token)) : null;

      //обьявляем скопы стейт менеджера 
      final checkAuthBlock = CheckBloc(token: token);
      final userBlock = UserBloc(repo: repositoryScope.userhRepo);
      final authBlock = AuthBloc(repo: repositoryScope.authRepo);
      blockScope = BlocksScope(authBlock: authBlock, userBloc: userBlock, checkBloc: checkAuthBlock, );
      //Иницилизированные параметры

      
      return true;
    } catch (e, st) {
      log('App Container has not been initialized', error: e, stackTrace: st);
      return false;
    }
  }
}

