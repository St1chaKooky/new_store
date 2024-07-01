part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthUnknow extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSucces extends AuthState {
  final UserModel user;

  AuthSucces({required this.user});
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError({required this.errorMessage});
  
}