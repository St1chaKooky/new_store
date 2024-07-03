part of 'user_bloc.dart';

@immutable
class UserState {}

class UserLoading extends UserState {}

class UserSucces extends UserState {
  final CurrentAuthModel user;

  UserSucces({required this.user});
}

class UserError extends UserState {
   final String errorMessage;

  UserError({required this.errorMessage});
}

