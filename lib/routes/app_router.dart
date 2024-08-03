
import 'package:flutter_chat/pages/pages.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersPages(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const UsersPages(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const UsersPages(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const UsersPages(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const UsersPages(),
    ),
  ]
);
