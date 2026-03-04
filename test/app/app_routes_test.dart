import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/app/app_routes.dart';

void main() {
  group('AppRoutes Tests', () {
    testWidgets('should push replacement route', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => AppRoutes.pushReplacement(
                context,
                const Scaffold(body: Text('New Page')),
              ),
              child: const Text('Navigate'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();
      expect(find.text('New Page'), findsOneWidget);
    });
  });
}
