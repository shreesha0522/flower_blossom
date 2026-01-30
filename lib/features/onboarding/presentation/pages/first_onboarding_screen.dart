import 'package:flutter/material.dart';
import 'second_onboarding_screen.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/onboarding.png',
              fit: BoxFit.cover,
            ),
          ),
          // Optional overlay for readability
          Container(color: Colors.black.withOpacity(0.2)),
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 48 : 24,
              ),
              child: Column(
                children: [
                  const Spacer(), // push content to bottom
                  // Title
                  Text(
                    "Welcome to Blossom 🌸",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 48 : 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 12),
                  // Description
                  Text(
                    "Plant, grow, and explore beautiful flowers with us.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 24 : 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: isTablet ? 40 : 30),
                  // Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondOnboardingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 222, 136, 165),
                      minimumSize: Size(
                        isTablet ? 300 : 200,
                        isTablet ? 60 : 50,
                      ),
                      textStyle: TextStyle(
                        fontSize: isTablet ? 20 : 16,
                      ),
                    ),
                    child: const Text("Next"),
                  ),
                  SizedBox(height: isTablet ? 60 : 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}