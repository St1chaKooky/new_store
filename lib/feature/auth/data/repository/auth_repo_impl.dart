import 'package:dio/dio.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/auth/data/models/post_user_model.dart';
import 'package:new_store/feature/auth/data/models/refresh_token_body.dart';
import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:new_store/feature/auth/data/service/auth_api_client.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthApiClient _authApiClient;
  final SecureRepo _secureRepo;
  AuthRepoImpl(this._authApiClient, this._secureRepo);
  @override
  Future<Result<UserModel>> signIn(String username, String password,
      [int expiresInMins = 1]) async {
    try {
      PostUserModel postUser = PostUserModel(
        password: password,
        username: username,
        expiresInMins: expiresInMins,
      );
      final UserModel user = await _authApiClient.signIn(postUser);
      await _secureRepo.addValue('token', user.token);
      await _secureRepo.addValue('refreshToken', user.refreshToken);
      return DataResult(user);
    } on DioException catch (error) {
      if (error.response != null) {
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

  @override
  Future<Result<void>> refresh() async {
    final refreshToken = await _secureRepo.readValue('refreshToken');
    if (refreshToken == null) {
      return const Result.error(['refreshToken does not exists']);
    }

    try {
      final refreshResult = await _authApiClient.refreshToken(RefreshTokenBody(
        refreshToken: refreshToken,
      ));
      await _secureRepo.addValue('refreshToken', refreshResult.refreshToken);
      await _secureRepo.addValue('token', refreshResult.token);
      return const VoidResult();
    } on DioException catch (e) {
      if (e.response == null) {
        return const Result.error(['response does not exists']);
      }

      final Response(:data, :statusCode) = e.response!;
      return Result.error(['${data.toString()} ($statusCode)']);
    }
  }
}
