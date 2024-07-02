import 'package:dio/dio.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';
import 'package:retrofit/retrofit.dart';
part 'user_api_client.g.dart';
@RestApi(baseUrl: 'https://dummyjson.com/user/')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  @GET('/me')
  Future<CurrentAuthModel> getCurrentUser();
}