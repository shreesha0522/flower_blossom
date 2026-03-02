import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/cart_screen.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

void main() {
  group('CartItem Tests', () {

    // Test 1: CartItem should store correct values
    test('should create CartItem with correct values', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
      );

      expect(item.name, 'Red Rose');
      expect(item.price, 10.0);
      expect(item.quantity, 1); // default
      expect(item.isBouquet, false); // default
      expect(item.deliveryCharge, 100); // default
    });

    // Test 2: totalPrice should be correct without bouquet
    test('totalPrice should be price * quantity + deliveryCharge', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
        quantity: 2,
      );

      // 10 * 2 + 100 = 120
      expect(item.totalPrice, 120.0);
    });

    // Test 3: totalPrice should include bouquet charge
    test('totalPrice should include bouquet charge when isBouquet is true', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
        quantity: 1,
        isBouquet: true,
      );

      // 10 * 1 + 1400 + 100 = 1510
      expect(item.totalPrice, 1510.0);
    });

    // Test 4: quantity can be updated
    test('should allow quantity to be updated', () {
      final item = CartItem(
        name: 'Sunflower',
        image: 'assets/images/Picture1.png',
        price: 15.0,
      );

      item.quantity = 3;
      expect(item.quantity, 3);
    });

    // Test 5: totalPrice updates when quantity changes
    test('totalPrice should update when quantity changes', () {
      final item = CartItem(
        name: 'Sunflower',
        image: 'assets/images/Picture1.png',
        price: 15.0,
        quantity: 3,
      );

      // 15 * 3 + 100 = 145
      expect(item.totalPrice, 145.0);
    });

  });

  group('CartScreen Widget Tests', () {

    // Test 6: Should render cart screen with empty items
    testWidgets('should display cart screen with empty cart', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cartItems: []),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CartScreen), findsOneWidget);
    });

    // Test 7: Should display cart items when items exist
    testWidgets('should display cart items when present', (tester) async {
      final cartItems = [
        CartItem(
          name: 'Red Rose',
          image: 'assets/images/Picture1.png',
          price: 10.0,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cartItems: cartItems),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Red Rose'), findsOneWidget);
    });

  });
}