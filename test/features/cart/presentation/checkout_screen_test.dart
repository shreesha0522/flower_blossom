import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/cart/presentation/checkout_screen.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

void main() {
  group('CheckoutScreen Widget Tests', () {

    // Helper to build checkout screen
    Widget buildCheckout({List<CartItem>? items}) {
      return ProviderScope(
        child: MaterialApp(
          home: CheckoutScreen(
            cartItems: items ?? [],
            userName: 'John Doe',
            userLocation: 'Kathmandu, Nepal',
          ),
        ),
      );
    }

    // Test 1: CheckoutScreen renders correctly
    testWidgets('should display checkout screen', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      expect(find.byType(CheckoutScreen), findsOneWidget);
    });

    // Test 2: Should display app bar with Checkout title
    testWidgets('should display Checkout title in app bar', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      expect(find.text('Checkout'), findsOneWidget);
    });

    // Test 3: Should display user name and location
    testWidgets('should display user name and location', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Kathmandu, Nepal'), findsOneWidget);
    });

    // Test 4: Should display cart items
    testWidgets('should display cart items in checkout', (tester) async {
      final items = [
        CartItem(
          name: 'Red Rose',
          image: 'assets/images/Picture1.png',
          price: 10.0,
        ),
      ];

      await tester.pumpWidget(buildCheckout(items: items));
      await tester.pumpAndSettle();

      expect(find.text('Red Rose'), findsOneWidget);
    });

    // Test 5: Should display phone validation error when empty
    testWidgets('should show error when phone number is empty', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      // Scroll to button
      await tester.dragUntilVisible(
        find.text('Proceed to Pay'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      await tester.tap(find.text('Proceed to Pay'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your phone number'), findsOneWidget);
    });

    // Test 6: Should display delivery options
    testWidgets('should display delivery options dropdown', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      expect(find.text('Delivery Options'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    // Test 7: Should display grand total
    testWidgets('should display grand total text', (tester) async {
      await tester.pumpWidget(buildCheckout());
      await tester.pumpAndSettle();

      expect(find.textContaining('Grand Total'), findsOneWidget);
    });

  });
}