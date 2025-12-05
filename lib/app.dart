import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';


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
      
    );
  }
}
