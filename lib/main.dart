import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_blossom/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import 'features/onboarding/onboarding_flow.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingFlow(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
