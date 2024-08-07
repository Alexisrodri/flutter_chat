
import 'package:flutter_chat/pages/pages.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/users',
  routes: [
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersPages(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatPages(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPages(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPages(),
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingPage(),
    ),
  ]
);
