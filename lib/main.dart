import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/app_router.dart';
import 'package:flutter_chat/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
      ),
    );
  }
}