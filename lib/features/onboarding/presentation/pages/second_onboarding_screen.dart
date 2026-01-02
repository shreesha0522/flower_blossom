import 'package:flutter/material.dart';
import 'final_onboarding_screen.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> flowerTypes = [
      "Roses",
      "Tulips",
      "Lilies",
      "Sunflowers",
      "Orchids",
      "Daisies",
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
                "Choose Your Favorite Flowers 🌺",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: flowerTypes
                        .map(
                          (flower) => Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                flower,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FinalOnboardingScreen(),
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
                    "Continue",
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
