import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/helpers/show_alert.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:flutter_chat/widgets/custom_button.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';

import '../widgets/labels.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Logo(),
                  _Form(),
                  const Labels(
                    text: 'No tienes una cuenta?',
                    buttonName: 'Crear una ahora!',
                    routeName: 'registerPage',
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: const Text(
                      'Términos y condiciones de uso',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail,
            placeholder: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailController,
          ),
          CustomInput(
            icon: Icons.password,
            placeholder: 'Contraseña',
            isPassword: true,
            textEditingController: passwordController,
          ),
          CustomButton(
              backgroundColor:
                  authService.startAuth ? Colors.black38 : Colors.black,
              text: authService.startAuth
                  ? const CupertinoActivityIndicator(color: Colors.white)
                  : const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
              onPressed: authService.startAuth
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final resultLogin = await authService.login(
                          emailController.text.trim(),
                          passwordController.text.trim());

                      if (resultLogin) {
                        // CONECTAR A NUESTRO SOCKET SERVER

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'usersPage');
                      } else {
                        // ignore: use_build_context_synchronously
                        showAlert(
                            context, 'Error', 'Correo o contraseña incorrecta');
                      }
                    })
        ],
      ),
    );
  }
}
