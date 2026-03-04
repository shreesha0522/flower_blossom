import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/app/common/my_snack_bar.dart';

void main() {
  group('MySnackBar Tests', () {
    testWidgets('should show snackbar with message', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => showMySnackBar(
                context: context,
                message: 'Hello!',
              ),
              child: const Text('Show'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.text('Hello!'), findsOneWidget);
    });

    testWidgets('should show snackbar with custom color', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => showMySnackBar(
                context: context,
                message: 'Colored!',
                color: Colors.green,
              ),
              child: const Text('Show'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.text('Colored!'), findsOneWidget);
    });
  });
}
