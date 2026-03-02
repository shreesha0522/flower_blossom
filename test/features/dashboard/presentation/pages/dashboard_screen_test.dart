import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/dashboard_screen.dart';

void main() {
  group('DashboardScreen Widget Tests', () {

    Widget buildDashboard() {
      return const ProviderScope(
        child: MaterialApp(
          home: DashboardScreen(),
        ),
      );
    }

    // Test 1: DashboardScreen renders correctly
    testWidgets('should display dashboard screen', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    // Test 2: Should display bottom navigation bar
    testWidgets('should display bottom navigation bar', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    // Test 3: Should display all 4 navigation items
    testWidgets('should display all 4 navigation items', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      expect(find.text('Home'), findsWidgets);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    // Test 4: Should start on Home screen
    testWidgets('should start on Home tab', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    // Test 5: Should navigate to Cart when tapped
    testWidgets('should navigate to Cart when Cart tab is tapped', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.shopping_bag));
      await tester.pump();

      expect(find.text('Cart'), findsWidgets);
    });

    // Test 6: Should navigate to About when tapped
    testWidgets('should navigate to About when About tab is tapped', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      await tester.tap(find.byIcon(Icons.info));
      await tester.pump();

      expect(find.text('About'), findsWidgets);
    });

    // Test 7: Should display app bar on Home screen
    testWidgets('should display app bar on home screen', (tester) async {
      await tester.pumpWidget(buildDashboard());
      await tester.pump();

      expect(find.byType(AppBar), findsOneWidget);
    });

  });
}