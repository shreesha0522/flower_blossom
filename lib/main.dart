import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flower_blossom/features/onboarding/onboarding_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import your screens
import 'features/splash/presentation/pages/splash_screen.dart';


import 'core/services/storage/user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  print('🔥 FLOWER BLOSSOM APP STARTED 🔥');
  
  // Initialize Hive
  print('📦 Initializing Hive...');
  await Hive.initFlutter();
  print('✅ Hive initialized successfully!');
  
  // Initialize SharedPreferences
  print('📦 Initializing SharedPreferences...');
  final sharedPreferences = await SharedPreferences.getInstance();
  print('✅ SharedPreferences initialized successfully!');
  
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
        '/onboarding': (context) => OnboardingFlow(), // ← Points to your flow controller
        '/login': (context) => LoginPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/onboarding':
            return MaterialPageRoute(builder: (context) => OnboardingFlow());
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginPage());
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
