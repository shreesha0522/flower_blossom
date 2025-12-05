import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/onboarding_screen.dart';
import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';
import 'screen/dashboard_screen.dart';

void main() {
  runApp(const BlossomApp());
}

class BlossomApp extends StatelessWidget {
  const BlossomApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Your MaterialApp with routes goes here
    return MaterialApp(
      title: 'Blossom',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // starts at splash
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) =>  LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
