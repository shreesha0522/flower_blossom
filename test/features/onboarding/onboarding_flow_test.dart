import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/first_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/second_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/presentation/pages/final_onboarding_screen.dart';
import 'package:flower_blossom/features/onboarding/onboarding_flow.dart';

void main() {
  group('Onboarding Screen Tests', () {

    // Test 1: First onboarding screen renders correctly
    testWidgets('should display first onboarding screen', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: FirstOnboardingScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FirstOnboardingScreen), findsOneWidget);
    });

    // Test 2: Second onboarding screen renders correctly
    testWidgets('should display second onboarding screen', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SecondOnboardingScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SecondOnboardingScreen), findsOneWidget);
    });

    // Test 3: Final onboarding screen renders correctly
    testWidgets('should display final onboarding screen', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: FinalOnboardingScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FinalOnboardingScreen), findsOneWidget);
    });

    // Test 4: Final onboarding screen has Start Exploring button
    testWidgets('should display Start Exploring button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: FinalOnboardingScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Start Exploring'), findsOneWidget);
    });

    // Test 5: OnboardingFlow renders PageView
    testWidgets('should display onboarding flow with PageView', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: OnboardingFlow(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PageView), findsOneWidget);
    });

  });
}