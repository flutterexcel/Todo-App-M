// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class LoginFailureEvent extends LoginEvent {}

class GoogleLoginSuccessEvent extends LoginEvent {}

// class NewUserEvent extends LoginEvent {
//   String email;
//   String password;

//   NewUserEvent(this.email, this.password);
// }

class LoginUserEvent extends LoginEvent {
  String email;
  String password;

  LoginUserEvent(this.email, this.password);
}
