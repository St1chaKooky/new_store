import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';

import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final SecureRepo secureRepo;
  AuthBloc({required this.authRepo, required this.secureRepo}) : super(AuthLoading()) {
    on<LoginEvent>((event, emit) => signInHandler(event, emit, authRepo));
    on<CheckAuthEvent>((event, emit) => checkAuthHandler(event, emit, secureRepo),);
  }

  void checkAuthHandler(CheckAuthEvent event, Emitter<AuthState> emit, SecureRepo secureRepo) async {
    emit(AuthLoading());
    final token = await secureRepo.readValue('token'); 
    if (token != null){
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  void signInHandler(
    LoginEvent event, Emitter<AuthState> emit, AuthRepo repo) async {
      emit(AuthLoading());
      final result = await repo.signIn(event.username,event.password);
      switch (result) {
        case DataResult(: final data): emit(AuthSucces(user: data));
        case ErrorResult(:final errorList): emit(AuthError(errorMessage: errorList.join(', ')));
      }
  }
}
