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
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          final args = settings.arguments as Map<String, String>?;

          return MaterialPageRoute(
            builder: (context) => DashboardScreen(
              firstName: args?['firstName'] ?? '',
              lastName: args?['lastName'] ?? '',
              email: args?['email'] ?? '',
              address: args?['address'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}
