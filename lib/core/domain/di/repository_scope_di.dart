import 'package:new_store/feature/account/domain/repository/user_repo.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';
import 'package:new_store/feature/product/domain/repository/product_repo.dart';

class RepositoryScope {
  final ProductRepo productRepo;
  final UserRepo userhRepo;
  final AuthRepo authRepo;
  RepositoryScope({
    required this.productRepo,
    required this.userhRepo,
    required this.authRepo,
  });
}