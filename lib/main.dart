import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_blossom/features/onboarding/onboarding_flow.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/dashboard_screen.dart'; // ← ADDED THIS
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Import your screens
import 'features/splash/presentation/pages/splash_screen.dart';
import 'core/services/storage/user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferenceProvider.overrideWithValue(sharedPreferences),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flower Blossom',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingFlow(),
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardScreen(), // ← ADDED THIS
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/onboarding':
            return MaterialPageRoute(builder: (context) => OnboardingFlow());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
          case '/dashboard':
            return MaterialPageRoute(builder: (context) => DashboardScreen()); // ← ADDED THIS
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: Text('Route not found: ${settings.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}