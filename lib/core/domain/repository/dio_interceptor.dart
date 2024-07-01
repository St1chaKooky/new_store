import 'dart:developer';

import 'package:dio/dio.dart';

class  DioInterceptor  extends  Interceptor { 
  final String token;
  DioInterceptor(this.token);
  
  @override 
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) { 
    // получить токен из хранилища 
      options.headers.addAll({ 
        "Authorization" : "Bearer ${token} " , 
      }); 
    return  super.onRequest(options, handler); 
  } 
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {
      log("Error responce secure", error: err, );
    }
    super.onError(err, handler);
  }
}