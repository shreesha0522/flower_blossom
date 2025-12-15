import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/onboarding_screen.dart';
import 'screen/login_screen.dart';
import 'screen/signup_screen.dart';
import 'screen/dashboard_screen.dart';

class BlossomApp extends StatelessWidget {
  const BlossomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Blossom',
      debugShowCheckedModeBanner: false,

      // 🌸 App theme
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),

      // 🌸 Start from Splash Screen
      initialRoute: '/',

      // 🌸 Named Routes
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}
