import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/chat_page.dart';
import 'package:flutter_chat/pages/loading_page.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/register_page.dart';
import 'package:flutter_chat/pages/users_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usersPage': (_) => const UsersPage(),
  'chatPage': (_) => const ChatPage(),
  'loadingPage': (_) => const LoadingPage(),
  'registerPage': (_) => const RegisterPage(),
  'loginPage': (_) => const LoginPage(),
};
