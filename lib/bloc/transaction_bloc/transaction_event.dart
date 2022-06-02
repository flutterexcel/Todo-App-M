import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionInitialEvent extends TransactionEvent {}
