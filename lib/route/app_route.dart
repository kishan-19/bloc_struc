import 'package:bloc_struc/screen/list/list_screen.dart';
import 'package:bloc_struc/screen/user/user_screen.dart';
import 'package:go_router/go_router.dart';

import '../screen/login/login_screen.dart';

class AppRoute {
  static const String login = "/login";
  static const String list = "/list";
  static const String user = "/user";
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoute.login,
  routes: [
    GoRoute(path: AppRoute.login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: AppRoute.list, builder: (context, state) => const ListScreen()),
    GoRoute(path: AppRoute.user, builder: (context, state) => const UserScreen()),
  ],
);
