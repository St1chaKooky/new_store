part of 'check_bloc.dart';

@immutable
abstract class CheckState {}

class CheckLoading extends CheckState {}

class CheckAuthSucces extends CheckState {}
class CheckUnAuthSucces extends CheckState {}

class CheckError extends CheckState {}
