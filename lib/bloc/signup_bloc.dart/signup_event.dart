// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupInitialEvent extends SignupEvent {}

class SignupSuccessEvent extends SignupEvent {
  String imgPath;
  String newUsername;
  String newEmail;
  String newPassword;

  SignupSuccessEvent(
      this.newEmail, this.newPassword, this.newUsername, this.imgPath);
}

class ImagePickerEvent extends SignupEvent {}
