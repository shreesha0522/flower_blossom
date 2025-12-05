
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger navigation after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      
      Navigator.pushNamed(context, '/onboarding');


    });

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: Center(
        child: Image.asset(
          'assets/images/Picture1.png',
          width: 300,
        ),
      ),
    );
  }
}