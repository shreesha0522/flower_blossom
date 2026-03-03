import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/cart_screen.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

void main() {
  group('CartItem Tests', () {
    test('should create CartItem with correct values', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
      );
      expect(item.name, 'Red Rose');
      expect(item.price, 10.0);
      expect(item.quantity, 1);
      expect(item.isBouquet, false);
      expect(item.deliveryCharge, 100);
    });

    test('totalPrice should be price * quantity + deliveryCharge', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
        quantity: 2,
      );
      expect(item.totalPrice, 120.0);
    });

    test('totalPrice should include bouquet charge when isBouquet is true', () {
      final item = CartItem(
        name: 'Red Rose',
        image: 'assets/images/Picture1.png',
        price: 10.0,
        quantity: 1,
        isBouquet: true,
      );
      expect(item.totalPrice, 1510.0);
    });

    test('should allow quantity to be updated', () {
      final item = CartItem(
        name: 'Sunflower',
        image: 'assets/images/Picture1.png',
        price: 15.0,
      );
      item.quantity = 3;
      expect(item.quantity, 3);
    });

    test('totalPrice should update when quantity changes', () {
      final item = CartItem(
        name: 'Sunflower',
        image: 'assets/images/Picture1.png',
        price: 15.0,
        quantity: 3,
      );
      expect(item.totalPrice, 145.0);
    });
  });

  group('CartScreen Widget Tests', () {
    testWidgets('should display cart screen with empty cart', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: CartScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsOneWidget);
    });

    testWidgets('should display cart screen', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: CartScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsOneWidget);
    });
  });
}
