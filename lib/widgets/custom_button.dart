import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final Color backgroundColor;
  final Function()? onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 60.0,
        child: TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(backgroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
            onPressed: onPressed,
            child: text));
  }
}
