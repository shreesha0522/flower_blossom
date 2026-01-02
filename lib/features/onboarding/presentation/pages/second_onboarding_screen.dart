import 'package:flutter/material.dart';
import 'final_onboarding_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(24),
                  
                  child: Column(
                    children: [
                      const Text(
                        "Discover Garden Activities 🌿",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // title in black
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Learn gardening tips, flower arrangements, and join our community.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // description in black
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FinalOnboardingScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  const Color.fromARGB(255, 222, 136, 165),
                          minimumSize: const Size(180, 50),
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
