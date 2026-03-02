import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_blossom/core/services/storage/user_session.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';
import 'package:flower_blossom/features/auth/presentation/view_model/auth_viewmodel.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/profile_screen.dart';

// ✅ Mock AuthViewModel that returns a fake logged-in user
class MockAuthViewModel extends AuthViewModel {
  @override
  AuthState build() {
    return AuthState.authenticated(
      const AuthEntity(
        authId: 'test-user-123',
        firstName: 'John',
        lastName: 'Doe',
        username: 'johndoe',
        email: 'john@example.com',
        password: 'password123',
      ),
    );
  }
}

void main() {
  group('ProfileScreen Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    Widget buildProfileScreen() {
      return ProviderScope(
        overrides: [
          sharedPreferenceProvider.overrideWithValue(prefs),
          // ✅ Override with mock so tests see a logged-in user
          authViewModelProvider.overrideWith(() => MockAuthViewModel()),
        ],
        child: const MaterialApp(
          home: ProfileScreen(
            firstName: 'John',
            lastName: 'Doe',
            username: 'johndoe',
            email: 'john@example.com',
            password: 'password123',
          ),
        ),
      );
    }

    testWidgets('should display profile screen', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('should display My Profile title', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      expect(find.text('My Profile'), findsOneWidget);
    });

    testWidgets('should display First Name field', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      expect(find.text('First Name'), findsOneWidget);
    });

    testWidgets('should display Email field', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('should display Edit Profile button', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.text('Edit Profile'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      expect(find.text('Edit Profile'), findsOneWidget);
    });

    testWidgets('should show Save Changes when Edit Profile is tapped',
        (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.text('Edit Profile'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Edit Profile'));
      await tester.pumpAndSettle();
      expect(find.text('Save Changes'), findsOneWidget);
    });

    testWidgets('should cancel editing when Cancel is tapped', (tester) async {
      await tester.pumpWidget(buildProfileScreen());
      await tester.pumpAndSettle();
      await tester.dragUntilVisible(
        find.text('Edit Profile'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );
      await tester.tap(find.text('Edit Profile'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pump();                            // process the tap
      await tester.pump(const Duration(seconds: 3)); // drain the 2s overlay timer
      expect(find.text('Edit Profile'), findsOneWidget);
    });
  });
}