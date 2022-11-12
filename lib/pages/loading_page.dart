import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/users_page.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: checkLoginState(context),
            builder: (context, snapshot) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }));
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final auth = await authService.isLogged();

    if (auth) {
      //CONECTAR AL SOCKET SERVER
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const UsersPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
              transitionDuration: const Duration(milliseconds: 0)));
    }
  }
}
