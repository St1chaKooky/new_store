import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';
import 'package:new_store/feature/account/domain/repository/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo repo;
  UserBloc({required this.repo}) : super(UserLoading()){
    on<GetCurrentUser>((event, emit) => getCurrentUser(event,emit,repo),);
  }
  void getCurrentUser(GetCurrentUser event, Emitter<UserState> emit, UserRepo repo) async {
    emit(UserLoading());
    final result = await repo.getCurrentUser();
    log(result.toString());
    switch (result) {
      case DataResult(:final data) : emit(UserSucces(user: data));
      case ErrorResult(:final errorList) : emit (UserError(errorMessage:errorList.join(', ')));
    }
  }
  @override
  void onChange(Change<UserState> change) {
    log(change.currentState.toString());
    super.onChange(change);
  }
}
