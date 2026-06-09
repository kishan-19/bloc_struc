import 'package:bloc_struc/database/user/model/user_model.dart';
import 'package:bloc_struc/screen/user/bloc/user_event.dart';
import 'package:bloc_struc/screen/user/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/user/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final HiveService hiveService = HiveService();
  UserBloc() : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) {
      hiveService.addUser(UserModel(name: "kishan", age: 20));
      hiveService.addUser(UserModel(name: "dsf", age: 230));
      hiveService.addUser(UserModel(name: "sd", age: 230));
        emit(UserLoaded(hiveService.getUsers()));
    });
  }
}
