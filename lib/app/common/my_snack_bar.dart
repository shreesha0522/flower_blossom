import 'package:flutter/material.dart';

showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 23)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color ?? const Color.fromARGB(255, 229, 128, 162),
      duration: Duration(seconds: 2),
    ),
  );
}