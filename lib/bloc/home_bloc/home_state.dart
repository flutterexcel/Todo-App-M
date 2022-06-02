import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeFailureState extends HomeState {}

class CategoryTaskState extends HomeState {
  final List dont;
  @override
  List<Object> get props => [dont];

  CategoryTaskState(this.dont);
}

class GoogleSignOutState extends HomeState {}
