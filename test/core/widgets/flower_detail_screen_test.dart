import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/core/widgets/flower_detail_screen.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

Widget buildScreen({Function(CartItem)? onAddToCart}) {
  return MaterialApp(
    home: FlowerDetailScreen(
      flowerName: 'Rose',
      flowerImage: 'assets/images/onboarding.png',
      description: 'A beautiful red rose.',
      price: 500,
      onAddToCart: onAddToCart ?? (_) {},
    ),
  );
}

void main() {
  group('FlowerDetailScreen Widget Tests', () {
    testWidgets('should display flower name', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('Rose'), findsWidgets);
    });

    testWidgets('should display description', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('A beautiful red rose.'), findsOneWidget);
    });

    testWidgets('should display Add to Cart button', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('should display quantity as 1 initially', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should increase quantity when + is tapped', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('should decrease quantity after increase', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle_outline));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove_circle_outline));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should not decrease quantity below 1', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.byIcon(Icons.remove_circle_outline));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should toggle bouquet switch', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      final switchFinder = find.byType(Switch);
      final Switch before = tester.widget(switchFinder);
      expect(before.value, false);
      await tester.tap(switchFinder);
      await tester.pump();
      final Switch after = tester.widget(switchFinder);
      expect(after.value, true);
    });

    testWidgets('should toggle favorite icon', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('should show Added to Cart popup', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Added to Cart'), findsOneWidget);
    });

    testWidgets('should close popup when OK tapped', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Added to Cart'), findsNothing);
    });

    testWidgets('should call onAddToCart with correct CartItem', (tester) async {
      CartItem? addedItem;
      await tester.pumpWidget(buildScreen(onAddToCart: (item) => addedItem = item));
      await tester.pump();
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();
      expect(addedItem?.name, 'Rose');
      expect(addedItem?.price, 500);
      expect(addedItem?.quantity, 1);
    });

    testWidgets('should display Description label', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('should display Quantity label', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.text('Quantity'), findsOneWidget);
    });
  });
}
