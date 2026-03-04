import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/core/utils/snack_bar_utils.dart';

void main() {
  group('SnackbarUtils Tests', () {
    testWidgets('should show error snackbar', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => SnackbarUtils.showError(context, 'Error!'),
              child: const Text('Show Error'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('Show Error'));
      await tester.pump();
      expect(find.text('Error!'), findsOneWidget);
    });

    testWidgets('should show success snackbar', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () => SnackbarUtils.showSuccess(context, 'Success!'),
              child: const Text('Show Success'),
            );
          }),
        ),
      ));
      await tester.tap(find.text('Show Success'));
      await tester.pump();
      expect(find.text('Success!'), findsOneWidget);
    });
  });
}
