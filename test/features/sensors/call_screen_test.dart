import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/sensors/call_screen.dart';

void main() {
  group('CallScreen Tests', () {
    testWidgets('should display call screen', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CallScreen()));
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('should display Flower Blossom text', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CallScreen()));
      await tester.pump();
      expect(find.text('Flower Blossom'), findsOneWidget);
    });

    testWidgets('should display end call button', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: CallScreen()));
      await tester.pump();
      expect(find.byIcon(Icons.call_end), findsOneWidget);
    });
  });
}
