import 'package:dio/dio.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/auth/data/models/post_user_model.dart';
import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:new_store/feature/auth/data/service/auth_api_client.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

class AuthMockedRepo implements AuthRepo {
  final AuthApiClient _authApiClient;
  final SecureRepo _secureRepo;
  AuthMockedRepo(this._authApiClient, this._secureRepo);
  @override
  Future<Result<UserModel>> signIn(String username, String password) async {
    try {
      PostUserModel postUser = PostUserModel(password: password,username:username );
      final UserModel user = await _authApiClient.signIn(postUser);
      _secureRepo.addValue('token',user.token);
    return DataResult(user);
    } on DioException catch (error){
      if (error.response != null){
          return ErrorResult([extractMessage(error.response!.data.toString())]);
        } else {
          return ErrorResult([error.message.toString()]);
        }  
    }
  }
  String extractMessage(String input) {
  if (input.contains(':')) {
    var parts = input.split(':');
    if (parts.length > 1) {
      return parts[1].trim().replaceAll('}', '').trim();
    }
  }
  return input;
}
  
}

