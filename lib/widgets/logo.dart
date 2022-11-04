import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/tag-logo.png'),
              width: 160.0,
            )
          ],
        ),
      ),
    );
  }
}
