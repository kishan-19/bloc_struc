import 'package:equatable/equatable.dart';

import '../../../database/user/model/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState{}

class UserLoaded extends UserState {

  final List<UserModel> users;

  UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}