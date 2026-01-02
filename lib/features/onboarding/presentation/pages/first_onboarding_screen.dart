import 'package:flutter/material.dart';
import 'second_onboarding_screen.dart';

class FirstOnboardingScreen extends StatefulWidget {
  const FirstOnboardingScreen({super.key});

  @override
  State<FirstOnboardingScreen> createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> titles = [
    "Welcome to Blossom 🌸",
    "Flowers for Everyone 🌹",
    "Brighten Your Day 🌼"
  ];

  final List<String> subtitles = [
    "Discover the most beautiful flowers near you.",
    "Connect with others and share your love for flowers.",
    "Get started today and enjoy the Blossom experience!"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/blossom_bg1.png',
              fit: BoxFit.cover,
            ),
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: titles.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
                    child: Column(
                      children: [
                        Text(
                          titles[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          subtitles[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    titles.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.pinkAccent : Colors.white70,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_currentPage == titles.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SecondOnboardingScreen(),
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
                      "Next",
                      style: TextStyle(fontWeight: FontWeight.bold),
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
