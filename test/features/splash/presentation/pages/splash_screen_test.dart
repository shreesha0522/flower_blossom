import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/splash/presentation/pages/splash_screen.dart';
import 'package:flower_blossom/features/splash/presentation/pages/second_screen.dart';
import 'package:flower_blossom/features/onboarding/onboarding_flow.dart';

void main() {
  group('SplashScreen Tests', () {

    // Helper - MaterialApp with onboarding route defined
    Widget buildSplash() {
      return ProviderScope(
        child: MaterialApp(
          home: const SplashScreen(),
          routes: {
            '/onboarding': (context) => OnboardingFlow(),
          },
        ),
      );
    }

    // Test 1: SplashScreen renders correctly
    testWidgets('should display splash screen with logo', (tester) async {
      await tester.pumpWidget(buildSplash());
      await tester.pump();

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      // Fire the timer to avoid pending timer error
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    // Test 2: SplashScreen has correct background color
    testWidgets('should have pink background color', (tester) async {
      await tester.pumpWidget(buildSplash());
      await tester.pump();

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(scaffold.backgroundColor, const Color(0xFFFCE4EC));

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    // Test 3: SplashScreen has centered content
    testWidgets('should have centered content', (tester) async {
      await tester.pumpWidget(buildSplash());
      await tester.pump();

      expect(find.byType(Center), findsOneWidget);

      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

  });

  group('SecondScreen Tests', () {

    // Helper - taller screen to avoid overflow
    Widget buildSecondScreen() {
      return const ProviderScope(
        child: MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 900)),
            child: SecondScreen(),
          ),
        ),
      );
    }

    // Test 4: SecondScreen renders correctly
    testWidgets('should display second screen', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(buildSecondScreen());
      await tester.pumpAndSettle();

      expect(find.byType(SecondScreen), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    // Test 5: SecondScreen displays correct text
    testWidgets('should display correct tagline text', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(buildSecondScreen());
      await tester.pumpAndSettle();

      expect(find.text('Fresh flowers, delivered with love'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    // Test 6: SecondScreen has Continue button
    testWidgets('should display Continue button', (tester) async {
      tester.view.physicalSize = const Size(400, 900);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(buildSecondScreen());
      await tester.pumpAndSettle();

      expect(find.text('Continue'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

  });
}