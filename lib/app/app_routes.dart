// lib/app/app_routes.dart
import 'package:flutter/material.dart';

class AppRoutes {
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
