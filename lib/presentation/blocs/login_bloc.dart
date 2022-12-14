import 'package:bloc/bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    
    on<LoginRequested>((event, emit) async {
      var result = checkLogin(event.id, event.pwd);

      if (result) {
        emit(const LoginSuccess());
      } else {
        emit(const LoginFail());
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(const LogoutSuccess());
    });
  }
}

bool checkLogin(String id, String pwd) {
  bool loginResult = false;
  if ('test' == id && '1' == pwd) {
    loginResult = true;
  } else {
    loginResult = false;
  }
  return loginResult;
}
