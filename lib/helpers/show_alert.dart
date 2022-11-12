import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context, String title, String content) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                MaterialButton(
                    textColor: Colors.blue,
                    elevation: 5.0,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'))
              ],
            ));
  } else {
    return showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog( 
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Ok'))
              ],
            ));
  }
}
