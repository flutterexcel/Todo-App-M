import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {
  String path;

  SignupInitialState(this.path);
  @override
  List<Object> get props => [];
}

class SignupSuccessState extends SignupState {}

class SignupFailureState extends SignupState {}
