import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/routes.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'loadingPage',
        routes: appRoutes,
      ),
    );
  }
}
