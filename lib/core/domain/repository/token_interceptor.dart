import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

class TokenInterceptor extends Interceptor {
  final SecureRepo _secureRepo;
  final AuthRepo _authRepo;
  TokenInterceptor(this._secureRepo, this._authRepo);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureRepo.readValue('token');
    // получить токен из хранилища
    if (token != null) {
      log(token.toString());
      options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureRepo.readValue('refreshToken');

      if (refreshToken != null) {
        await _authRepo.refresh();
      }
      log(
        "Error responce secure",
        error: err,
      );
    }
    super.onError(err, handler);
  }
}
