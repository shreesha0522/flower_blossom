import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/cart/presentation/payment_screen.dart';

void main() {
  group('PaymentScreen Widget Tests', () {

    // Helper to build payment screen
    Widget buildPayment({double amount = 500.0}) {
      return MaterialApp(
        home: PaymentScreen(
          amount: amount,
          onPaymentSuccess: () async {},
        ),
      );
    }

    // Test 1: PaymentScreen renders correctly
    testWidgets('should display payment screen', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      expect(find.byType(PaymentScreen), findsOneWidget);
    });

    // Test 2: Should display Payment title in app bar
    testWidgets('should display Payment title in app bar', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      expect(find.text('Payment'), findsOneWidget);
    });

    // Test 3: Should display correct total amount
    testWidgets('should display correct total amount', (tester) async {
      await tester.pumpWidget(buildPayment(amount: 500.0));
      await tester.pumpAndSettle();

      expect(find.textContaining('500'), findsOneWidget);
    });

    // Test 4: Should display payment method options
    testWidgets('should display eSewa and Khalti payment options', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      expect(find.text('eSewa'), findsOneWidget);
      expect(find.text('Khalti'), findsOneWidget);
    });

    // Test 5: Should display Pay Now button
    testWidgets('should display Pay Now button', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      expect(find.text('Pay Now'), findsOneWidget);
    });

    // Test 6: Should display radio buttons for payment methods
    testWidgets('should display radio buttons for payment selection', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      expect(find.byType(RadioListTile<String>), findsNWidgets(2));
    });

    // Test 7: Should be able to select Khalti payment method
    testWidgets('should select Khalti when tapped', (tester) async {
      await tester.pumpWidget(buildPayment());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Khalti'));
      await tester.pumpAndSettle();

      final khaltiRadio = tester.widget<RadioListTile<String>>(
        find.widgetWithText(RadioListTile<String>, 'Khalti'),
      );
      expect(khaltiRadio.groupValue, 'khalti');
    });

  });
}