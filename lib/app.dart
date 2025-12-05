import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/dashboard_screen.dart';

void main() {
  runApp(const BlossomApp());
}

class BlossomApp extends StatelessWidget {
  const BlossomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blossom',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      // initialRoute: '/login', // 👈 start directly at login (or '/' if you want splash)
      // routes: {
      //   '/': (context) => SplashScreen(),
      //   '/login': (context) => LoginScreen(),
      //   '/dashboard': (context) => DashboardScreen(),
      //   '/signup': (context) => SignUpScreen(), // ✅ signup route
      // },
    );
  }
}
