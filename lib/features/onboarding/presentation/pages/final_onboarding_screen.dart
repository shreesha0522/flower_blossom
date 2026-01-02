import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';


class FinalOnboardingScreen extends StatelessWidget {
  const FinalOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> gardenActivities = [
      "Plant Flowers",
      "Flower Arrangement",
      "Gardening Tips",
      "Join Blossom Community",
      "Flower Delivery",
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Get Started With Blossom 🌸",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: gardenActivities
                      .map(
                        (activity) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.pinkAccent, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            activity,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    minimumSize: const Size(200, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Start Exploring",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
