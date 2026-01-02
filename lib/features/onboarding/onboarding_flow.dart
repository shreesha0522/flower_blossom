import 'package:flower_blossom/features/onboarding/presentation/pages/final_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/first_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/second_onboarding_screen.dart';
import 'package:flutter/material.dart';


class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        FirstOnboardingScreen(),
        SecondOnboardingScreen(),
        FinalOnboardingScreen(),
      ],
    );
  }
}
