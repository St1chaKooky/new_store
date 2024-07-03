import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Result<UserModel>> signIn(String username, String password,
      [final int expiresInMins = 1]);

  Future<Result<void>> refresh();
}
