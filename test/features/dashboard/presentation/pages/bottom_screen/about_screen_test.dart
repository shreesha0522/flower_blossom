import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/about_screen.dart';

Widget buildScreen() {
  return const MaterialApp(
    home: AboutScreen(userName: 'John Doe'),
  );
}

void main() {
  group('AboutScreen Widget Tests', () {
    testWidgets('should display the screen', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.byType(AboutScreen), findsOneWidget);
    });

    testWidgets('should display Nepal as default country', (tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      expect(find.textContaining('Nepal'), findsWidgets);
    });

    testWidgets('should show country dialog when country tapped', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Nepal').first);
      await tester.pumpAndSettle();
      expect(find.text('Select Country'), findsOneWidget);
    });

    testWidgets('should show all country options in dialog', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Nepal').first);
      await tester.pumpAndSettle();
      expect(find.text('Australia'), findsOneWidget);
      expect(find.text('USA'), findsOneWidget);
      expect(find.text('India'), findsOneWidget);
    });

    testWidgets('should select Australia from country dialog', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Nepal').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Australia'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Australia'), findsWidgets);
    });

    testWidgets('should toggle dark mode switch', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      final switchFinder = find.byType(Switch).first;
      final Switch before = tester.widget(switchFinder);
      expect(before.value, false);
      await tester.tap(switchFinder);
      await tester.pump();
      final Switch after = tester.widget(switchFinder);
      expect(after.value, true);
    });

    testWidgets('should show feedback dialog', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Feedback').first);
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should type feedback and submit', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Feedback').first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Great app!');
      await tester.pump();
      expect(find.text('Great app!'), findsOneWidget);
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(find.text('Thank you for your feedback!'), findsOneWidget);
    });

    testWidgets('should show account info dialog', (tester) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      await tester.tap(find.textContaining('Account').first);
      await tester.pumpAndSettle();
      expect(find.text('First Name:').evaluate().isNotEmpty ||
             find.textContaining('First Name').evaluate().isNotEmpty, true);
    });
  });
}
