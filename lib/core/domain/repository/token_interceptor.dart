import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;
  final SecureRepo _secureRepo;
  final AuthRepo _authRepo;
  TokenInterceptor(this._secureRepo, this._authRepo, this._dio);

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
    log(
        "Error responce secure",
        error: err,
      );
    if (err.response?.statusCode == 401) {
      final refreshToken = await _secureRepo.readValue('refreshToken');
      
      if (refreshToken != null) {
      try {
        await _authRepo.refresh();
        final newToken = await _secureRepo.readValue('token');
        if (newToken != null) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final cloneReq = await _dio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        }
      } catch (e) {
        // Handle the error if token refresh fails
        log("Token refresh failed", error: e);
      }
    }
  
    }

    super.onError(err, handler);
  }
}
