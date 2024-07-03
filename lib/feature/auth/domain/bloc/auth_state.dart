part of 'auth_bloc.dart';

@immutable
class AuthState {}

//check on auth


class Authenticated extends AuthState {}

class UnAuthenticated extends AuthState {}

//SignIn
class AuthLoading extends AuthState {}

class AuthSucces extends AuthState {
  final UserModel user;
  AuthSucces({required this.user});
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError({required this.errorMessage});
}

//logout
class LogoutSucces extends AuthState {}
