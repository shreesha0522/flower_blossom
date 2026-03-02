import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/home_screen.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

void main() {
  group('HomeScreen Widget Tests', () {

    Widget buildHomeScreen() {
      return MaterialApp(
        home: HomeScreen(
          onAddToCart: (CartItem item) {},
        ),
      );
    }

    testWidgets('should display home screen', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('should display search bar', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search flowers...'), findsOneWidget);
    });

    testWidgets('should display Shop Our Categories section', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.text('Shop Our Categories'), findsOneWidget);
    });

    testWidgets('should display Best Sellers section', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.text('Best Sellers'), findsOneWidget);
    });

    testWidgets('should display flower names in categories', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.text('Rose'), findsOneWidget);
    });

    testWidgets('should display search icon in search bar', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should filter out non-matching flowers when searching', (tester) async {
      await tester.pumpWidget(buildHomeScreen());
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'Rose');
      await tester.pump();
      expect(find.text('Tulip'), findsNothing);
    });

  });
}
