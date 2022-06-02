import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class GoogleLoginSuccessState extends LoginState {
  User? users;

  GoogleLoginSuccessState({this.users});
}

class LoginFailureState extends LoginState {
  String failureMessage = '';
  LoginFailureState({required this.failureMessage});
}

class LoginUserState extends LoginState {
  User user;

  LoginUserState(this.user);
}
