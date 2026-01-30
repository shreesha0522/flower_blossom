import 'package:flower_blossom/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('LoginPage Widget Tests', () {
    
    // Test 1: Widget renders with all required UI elements
    testWidgets('should display all login UI elements', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Assert - Check all widgets are present
      expect(find.byType(Image), findsOneWidget); // Logo
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text("Don't have an account? Sign up"), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    // Test 2: Email validation - empty email shows error
    testWidgets('should show error when email is empty', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Act - Find and tap login button without entering email
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump(); // Trigger validation

      // Assert
      expect(find.text('Please enter your email'), findsOneWidget);
    });

    // Test 3: Password validation - empty password shows error
    testWidgets('should show error when password is empty', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Act - Enter valid email but no password
      final emailFields = find.byType(TextFormField);
      await tester.enterText(emailFields.first, 'test@example.com');
      
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump();

      // Assert
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    // Test 4: Password validation - short password shows error
    testWidgets('should show error when password is less than 8 characters', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Act - Enter valid email but short password
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'test@example.com'); // Email
      await tester.enterText(textFields.last, 'pass123'); // Only 7 chars
      
      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump();

      // Assert
      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });

    // Test 5: User can enter text in email and password fields
    testWidgets('should allow user to enter email and password', (tester) async {
      // Arrange
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      // Act - Enter text in both fields
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.first, 'john@example.com');
      await tester.enterText(textFields.last, 'password123');
      await tester.pump();

      // Assert - Check if text was entered
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

  });
}