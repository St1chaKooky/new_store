import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/feature/splash/domain/bloc/check_bloc.dart';

class BlocksScope {
  final CheckBloc checkBloc;
  final UserBloc userBloc;
  final AuthBloc authBlock;
  BlocksScope({
    required this.checkBloc,
    required this.userBloc,
    required this.authBlock,
  });
}