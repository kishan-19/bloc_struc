import 'package:bloc_struc/route/app_route.dart';
import 'package:bloc_struc/screen/list/list_screen.dart';
import 'package:bloc_struc/screen/login/bloc/login_bloc.dart';
import 'package:bloc_struc/screen/login/bloc/login_event.dart';
import 'package:bloc_struc/screen/login/bloc/login_state.dart';
import 'package:bloc_struc/utiles/util.dart';
import 'package:bloc_struc/widgets/SmartTextInputWidget.dart';
import 'package:bloc_struc/widgets/coommon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              SmartTextInputWidget(
                titleController: emailController,
                titleText: "Email",
              ),
              SmartTextInputWidget(
                titleController: passwordController,
                titleText: "Password",
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailure) {
                    showSnackBar(state.error, context);
                  }
                  if(state is LoginSuccess){
                    showSnackBar("Login Success", context);
                    // startActivity(context, ListScreen());
                    context.go(AppRoute.user);
                  }
                },
                builder: (context, state) {
                  print("builde call logn<><><>");
                  return getCommonButton("Login", state is LoginLoading, () {
                    context.read<LoginBloc>().add(
                      LoginButtonPressed(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
