import 'package:flower_blossom/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flower_blossom/app/theme/theme_data.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getFlowerBlossomTheme(),
      home: SplashScreen(),
    );
  }
}