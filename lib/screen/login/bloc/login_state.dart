import 'package:equatable/equatable.dart';

import '../model/LoginModel.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User userData;
  LoginSuccess({required this.userData});

  @override
  List<Object?> get props => [userData];
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}