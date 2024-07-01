import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';

import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepo repo;
  AuthBloc({required this.repo}) : super(AuthLoading()) {
    on<LoginEvent>((event, emit) => signInHanler(event, emit, repo));
    on<StartEvent>(
      (event, emit) {
        emit(AuthUnknow());
      },
    );
  }

  void signInHanler(
    LoginEvent event, Emitter<AuthState> emit, AuthRepo repo) async {
      emit(AuthLoading());
      final result = await repo.signIn(event.username,event.password);
      switch (result) {
        case DataResult(: final data): emit(AuthSucces(user: data));
        case ErrorResult(:final errorList): emit(AuthError(errorMessage: errorList.join(', ')));
      }
  }
}
