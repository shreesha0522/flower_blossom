import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';


class FinalOnboardingScreen extends StatelessWidget {
  const FinalOnboardingScreen({super.key});

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

          // Optional overlay for readability
          Container(color: Colors.black.withOpacity(0.2)),

          // Bottom content with colored background
          SafeArea(
            child: Column(
              children: [
                const Spacer(), // push content to bottom

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  // bottom color
                  child: Column(
                    children: [
                      const Text(
                        "Get Started With Blossom 🌸",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // title in black
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Explore activities, delivery, and join our flower-loving community.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black, // description in black
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 222, 136, 165),
                          minimumSize: const Size(180, 50),
                        ),
                        child: const Text("Start Exploring"),
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
  //shreesha
}
