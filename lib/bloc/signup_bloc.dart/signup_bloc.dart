import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/login_bloc/login_event.dart';
import 'package:todo_app/bloc/login_bloc/login_state.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_event.dart';
import 'package:todo_app/bloc/signup_bloc.dart/signup_state.dart';
import 'package:todo_app/utils/email_authentication.dart';
import 'package:todo_app/utils/google_authentication.dart';
import 'package:todo_app/utils/storage_services.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitialState('')) {
    on<ImagePickerEvent>((event, emit) async {
      String path = await selectFile();
      emit(SignupInitialState(path));
    });

    on<SignupSuccessEvent>((event, emit) async {
      String url = await uploadFile(event.imgPath, event.newEmail);
      await newUserRegister(
          event.newEmail, event.newPassword, event.newUsername, url);
      emit(SignupSuccessState());
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
