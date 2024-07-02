import 'package:dio/dio.dart';
import 'package:new_store/feature/auth/data/models/post_user_model.dart';
import 'package:new_store/feature/auth/data/models/refresh_token_body.dart';
import 'package:new_store/feature/auth/data/models/refresh_token_response.dart';
import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/auth/')
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST('/login')
  Future<UserModel> signIn(@Body() PostUserModel postUser);

  @POST('/refresh')
  Future<RefreshTokenResponse> refreshToken(
      @Body() final RefreshTokenBody body);
}
