import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  String? token;
  CheckBloc({required this.token}) : super(CheckLoading()){
    on<CheckAuthUser>((event, emit) => checkAuthUser(event,emit,token),);
  }

  void checkAuthUser(CheckAuthUser event, Emitter<CheckState> emit, String? token){
    token == null ? emit(CheckUnAuthSucces()) : emit(CheckAuthSucces());
  }

}
