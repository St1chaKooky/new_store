import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';

class DioInterceptor extends Interceptor {
  final SecureRepo secureRepo;
  DioInterceptor(this.secureRepo);

  @override
  void onRequest(
RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureRepo.readValue('token');
    // получить токен из хранилища
    if (token != null) {
      log(token.toString());
      options.headers.addAll({
        "Authorization": "Bearer ${token}",
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {
      log(
        "Error responce secure",
        error: err,
      );
    }
    super.onError(err, handler);
  }
}
