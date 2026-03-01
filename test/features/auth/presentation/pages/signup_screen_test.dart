import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flower_blossom/features/auth/presentation/pages/signup_screen.dart';

void main() {
  group('SignUpPage Widget Tests', () {

    // Test 1: Widget renders with all required UI elements
    testWidgets('should display all signup UI elements', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - Check all widgets are present
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(6)); // 6 fields now
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Already have an account? Login'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
      expect(find.byIcon(Icons.alternate_email), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    // Test 2: First Name validation - empty shows error
    testWidgets('should show error when first name is empty', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Scroll to bottom to find signup button
      await tester.dragUntilVisible(
        find.widgetWithText(ElevatedButton, 'Sign Up'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      // Tap signup without entering first name
      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Please enter your first name'), findsOneWidget);
    });

    // Test 3: Username validation - too short shows error
    testWidgets('should show error when username is less than 3 characters',
        (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final firstNameField = find.ancestor(
        of: find.text('First Name'),
        matching: find.byType(TextFormField),
      );

      final lastNameField = find.ancestor(
        of: find.text('Last Name'),
        matching: find.byType(TextFormField),
      );

      final usernameField = find.ancestor(
        of: find.text('Username'),
        matching: find.byType(TextFormField),
      );

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(usernameField, 'ab'); // Only 2 chars

      await tester.dragUntilVisible(
        find.widgetWithText(ElevatedButton, 'Sign Up'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Username must be at least 3 characters'), findsOneWidget);
    });

    // Test 4: Email validation - invalid format shows error
    testWidgets('should show error when email format is invalid', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final firstNameField = find.ancestor(
        of: find.text('First Name'),
        matching: find.byType(TextFormField),
      );

      final lastNameField = find.ancestor(
        of: find.text('Last Name'),
        matching: find.byType(TextFormField),
      );

      final usernameField = find.ancestor(
        of: find.text('Username'),
        matching: find.byType(TextFormField),
      );

      final emailField = find.ancestor(
        of: find.text('Email'),
        matching: find.byType(TextFormField),
      );

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(usernameField, 'johndoe');
      await tester.enterText(emailField, 'invalidemail'); // Invalid email

      await tester.dragUntilVisible(
        find.widgetWithText(ElevatedButton, 'Sign Up'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    // Test 5: Password validation - passwords don't match shows error
    testWidgets('should show error when passwords do not match', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignUpPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final firstNameField = find.ancestor(
        of: find.text('First Name'),
        matching: find.byType(TextFormField),
      );

      final lastNameField = find.ancestor(
        of: find.text('Last Name'),
        matching: find.byType(TextFormField),
      );

      final usernameField = find.ancestor(
        of: find.text('Username'),
        matching: find.byType(TextFormField),
      );

      final emailField = find.ancestor(
        of: find.text('Email'),
        matching: find.byType(TextFormField),
      );

      final passwordField = find.ancestor(
        of: find.text('Password'),
        matching: find.byType(TextFormField),
      );

      final confirmPasswordField = find.ancestor(
        of: find.text('Confirm Password'),
        matching: find.byType(TextFormField),
      );

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(usernameField, 'johndoe');
      await tester.enterText(emailField, 'john@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.enterText(confirmPasswordField, 'password456'); // Different

      await tester.dragUntilVisible(
        find.widgetWithText(ElevatedButton, 'Sign Up'),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Sign Up'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

  });
}