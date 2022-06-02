import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_event.dart';
import 'package:todo_app/bloc/login_bloc/login_state.dart';
import 'package:todo_app/utils/email_authentication.dart';
import 'package:todo_app/utils/google_authentication.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>((event, emit) async {
      User user = await userLogin(event.email, event.password);
      emit(LoginUserState(user));
    });

    on<GoogleLoginSuccessEvent>((event, emit) async {
      User? users = await signInWithGoogle();
      emit(GoogleLoginSuccessState(users: users));
    });

    on<LoginInitialEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginInitialEvent) {
  //     yield* mapLoginEventToState(event);
  //   }
  // }

  // Stream<LoginState> mapLoginEventToState(LoginInitialEvent event) async* {
  //   try {
  //     var response = await signInWithGoogle().then((result) {});
  //     if (response != null) {
  //       yield LoginSuccessState();
  //     }
  //   } catch (e) {
  //     yield LoginFailureState(failureMessage: e.toString());
  //   }
  // }
}
