
import 'package:flutter_chat/pages/pages.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/users',
      builder: (context, state) => const UsersPages(),
    )

  ]
);
