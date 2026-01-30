import 'package:flutter/material.dart';
import 'final_onboarding_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    
    return Scaffold(
      body: Stack(
        children: [
          // Full screen background image
          SizedBox.expand(
            child: Image.asset(
              'assets/images/onboarding.png',
              fit: BoxFit.cover,
            ),
          ),
          // Optional dark overlay for readability
          Container(color: Colors.black.withOpacity(0.2)),
          // Bottom content with colored background
          SafeArea(
            child: Column(
              children: [
                const Spacer(), // push everything to bottom
                // Bottom container for title, description, button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isTablet ? 48 : 24),
                  child: Column(
                    children: [
                      Text(
                        "Discover Garden Activities 🌿",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 42 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: isTablet ? 20 : 12),
                      Text(
                        "Learn gardening tips, flower arrangements, and join our community.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: isTablet ? 32 : 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FinalOnboardingScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 222, 136, 165),
                          minimumSize: Size(
                            isTablet ? 280 : 180,
                            isTablet ? 60 : 50,
                          ),
                          textStyle: TextStyle(
                            fontSize: isTablet ? 20 : 16,
                          ),
                        ),
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}