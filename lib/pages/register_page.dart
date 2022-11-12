import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/custom_button.dart';
import 'package:flutter_chat/widgets/custom_input.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../services/auth_service.dart';
import '../widgets/labels.dart';
import '../widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                    text: 'Ya tienes una cuenta?',
                    buttonName: 'Ingresar ahora!',
                    routeName: 'loginPage',
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
  final nameController = TextEditingController();
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
            icon: Icons.person,
            placeholder: 'Nombre completo',
            keyboardType: TextInputType.text,
            textEditingController: nameController,
          ),
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
                      'Crear cuenta',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
              onPressed: authService.startAuth
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final resultRegister = await authService.register(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim());

                      if (resultRegister == true) {
                        // CONECTAR A NUESTRO SOCKET SERVER

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'usersPage');
                      } else {
                        // ignore: use_build_context_synchronously
                        showAlert(context, 'Error al crear cuenta',
                            '$resultRegister');
                      }
                    })
        ],
      ),
    );
  }
}
