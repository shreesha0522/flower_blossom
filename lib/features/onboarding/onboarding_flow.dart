// features/onboarding/presentation/onboarding_flow.dart
import 'package:flower_blossom/features/onboarding/presentation/pages/final_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/first_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/second_onboarding_screen.dart';
import 'package:flutter/material.dart';

// Import your 3 onboarding screens


class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _onboardingScreens = [
    FirstOnboardingScreen(),
    SecondOnboardingScreen(),
    FinalOnboardingScreen(),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingScreens.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last screen - navigate to login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skipToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingScreens.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _onboardingScreens[index];
              },
            ),
          ),
          
          // Page indicators and navigation
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                TextButton(
                  onPressed: _skipToLogin,
                  child: Text('Skip'),
                ),
                
                // Page indicators
                Row(
                  children: List.generate(
                    _onboardingScreens.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index 
                            ? Theme.of(context).primaryColor 
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                
                // Next/Done button
                ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _onboardingScreens.length - 1 
                        ? 'Get Started' 
                        : 'Next'
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
