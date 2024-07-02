import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/core/domain/secure/secure_repository.dart';
import 'package:new_store/feature/auth/data/models/user_model.dart';
import 'package:new_store/feature/auth/domain/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;
  final SecureRepo secureRepo;
  final GoRouter _router;

  AuthBloc({
    required this.authRepo,
    required this.secureRepo,
    required final GoRouter goRouter,
  })  : _router = goRouter,
        super(AuthLoading()) {
    on<LoginEvent>((event, emit) => signInHandler(event, emit, authRepo));
    on<CheckAuthEvent>(
      (event, emit) => checkAuthHandler(event, emit, secureRepo),
    );
    on<Logout>(
      (event, emit) => logoutHanler(event, emit, secureRepo),
    );
  }

  void checkAuthHandler(CheckAuthEvent event, Emitter<AuthState> emit,
      SecureRepo secureRepo) async {
    emit(AuthLoading());
    final token = await secureRepo.readValue('token');
    if (token != null) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);

    switch (change.nextState) {
      case Unknow():
      case AuthError():
      case AuthLoading():
        break;
      case AuthSucces():
      case Authenticated():
        _router.go(RouteList.account);
        break;
      case LogoutSucces():
      case UnAuthenticated():
        _router.go(RouteList.signIn);
        break;
    }

    if (change.nextState is UnAuthenticated) {}
  }

  void logoutHanler(
      Logout event, Emitter<AuthState> emit, SecureRepo secureRepo) async {
    emit(AuthLoading());
    await secureRepo.delete();
    emit(UnAuthenticated());
  }

  void signInHandler(
      LoginEvent event, Emitter<AuthState> emit, AuthRepo repo) async {
    emit(AuthLoading());
    final result = await repo.signIn(event.username, event.password);
    switch (result) {
      case DataResult(:final data):
        emit(AuthSucces(user: data));
      case ErrorResult(:final errorList):
        emit(AuthError(errorMessage: errorList.join(', ')));
    }
  }
}
