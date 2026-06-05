import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_struc/screen/login/bloc/login_event.dart';

import 'package:bloc_struc/screen/login/bloc/login_state.dart';
import 'package:bloc_struc/screen/login/model/LoginModel.dart';
import 'package:http/http.dart' as http;

import '../../../constant/api_end_point.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final Map<String, String> jsonBody = {
          "email": event.email,
          "from_app": "true",
          "password": event.password,
          "device_type": "android",
        };
        final url = Uri.parse(loginURl);

        final response = await http.post(
          url,
          body: jsonBody,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        );
        final statusCode = response.statusCode;
        final body = response.body;
        Map<String, dynamic> data = jsonDecode(body);
        LoginModel userModel = LoginModel.fromJson(data);

        if (statusCode == 200 && userModel.success == 1) {
          emit(LoginSuccess(userData: userModel.user ?? User()));
        } else {
          emit(LoginFailure(error: userModel.message ?? "filed to login",));
        }
      } catch (e) {
        emit(LoginFailure(error: "error $e"));
      }
    });
  }
}
