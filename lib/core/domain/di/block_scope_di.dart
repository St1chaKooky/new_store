import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/feature/product/domain/bloc/product_bloc.dart';

class BlocksScope {
  final ProductBloc productBloc;
  final UserBloc userBloc;
  final AuthBloc authBlock;
  BlocksScope({
    required this.productBloc,
    required this.userBloc,
    required this.authBlock,
  });
}