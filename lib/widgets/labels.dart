import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String text;
  final String buttonName;
  final String routeName;

  const Labels(
      {super.key,
      required this.routeName,
      required this.text,
      required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, routeName);
          },
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w800),
          ),
        )
      ],
    );
  }
}
