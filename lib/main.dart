import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/app_router.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:flutter_chat/services/chat_services.dart';
import 'package:flutter_chat/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatServices()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
      ),
    );
  }
}