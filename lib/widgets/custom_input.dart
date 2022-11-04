import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            left: 5.0, top: 5.0, bottom: 5.0, right: 20.0),
        margin: const EdgeInsets.only(bottom: 15.0),
        decoration: BoxDecoration(
            color: Colors.red.shade100.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
            controller: textEditingController,
            autocorrect: false,
            obscureText: isPassword,
            style: const TextStyle(color: Colors.black54, height: 1.3),
            keyboardType: keyboardType,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: Colors.red.shade500,
                ),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle:
                    const TextStyle(color: Colors.black54, height: 1.3))));
  }
}
