import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class AllTaskEvent extends HomeEvent {}

class PersonalTaskEvent extends HomeEvent {
  String categoryType;

  PersonalTaskEvent(this.categoryType);
}

class HomeTaskEvent extends HomeEvent {
  String categoryType;

  HomeTaskEvent(this.categoryType);
}

class WorkTaskEvent extends HomeEvent {
  String categoryType;

  WorkTaskEvent(this.categoryType);
}

class SchoolTaskEvent extends HomeEvent {
  String categoryType;

  SchoolTaskEvent(this.categoryType);
}

class GoogleSignOutEvent extends HomeEvent {
  BuildContext context;

  GoogleSignOutEvent(this.context);
}
