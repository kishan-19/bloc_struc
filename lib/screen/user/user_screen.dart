import 'package:bloc_struc/screen/user/bloc/user_bloc.dart';
import 'package:bloc_struc/screen/user/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.5, title: Text("User")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(state.users[index].name));
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
