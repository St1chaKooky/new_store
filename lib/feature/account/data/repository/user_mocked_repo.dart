import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';
import 'package:new_store/feature/account/data/service/user_api_client.dart';
import 'package:new_store/feature/account/domain/repository/user_repo.dart';

class UserMockedRepo implements UserRepo {
  final UserApiClient _userApiClient;
  final SecureRepo _secureRepo;

  UserMockedRepo(this._userApiClient, this._secureRepo);


  @override
  Future<Result<CurrentAuthModel>> getCurrentUser() async {
    try {
      final token = await _secureRepo.readValue('token');
      if (token != null){
        log(token);
        final user = await _userApiClient.getCurrentUser('Bearer $token');
        log(user.toString());
        return DataResult(user);
      }
      
      return ErrorResult(['token = null']);
    }on DioException catch(error) {
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