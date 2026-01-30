// features/onboarding/presentation/onboarding_flow.dart
import 'package:flower_blossom/features/onboarding/presentation/pages/final_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/first_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/second_onboarding_screen.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
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
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}