import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';

abstract class UserRepo {
  Future<Result<CurrentAuthModel>> getCurrentUser();
}