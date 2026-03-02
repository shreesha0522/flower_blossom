import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_blossom/core/services/storage/user_session.dart';

void main() {
  group('UserSessionService Tests', () {
    late UserSessionService userSessionService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      userSessionService = UserSessionService(sharedPreference: prefs);
    });

    // ── saveUserSession ──────────────────────────────────────────
    group('saveUserSession', () {
      test('should save all user session data correctly', () async {
        await userSessionService.saveUserSession(
          userId: 'user-123',
          email: 'john@example.com',
          username: 'johndoe',
          firstName: 'John',
          lastName: 'Doe',
        );

        expect(userSessionService.isLoggedIn(), true);
        expect(userSessionService.getUserId(), 'user-123');
        expect(userSessionService.getUserEmail(), 'john@example.com');
        expect(userSessionService.getUsername(), 'johndoe');
        expect(userSessionService.getUserFirstName(), 'John');
        expect(userSessionService.getUserLastName(), 'Doe');
      });

      test('should save profile picture when provided', () async {
        await userSessionService.saveUserSession(
          userId: 'user-123',
          email: 'john@example.com',
          username: 'johndoe',
          firstName: 'John',
          lastName: 'Doe',
          profilePicture: '/images/profile.jpg',
        );

        expect(userSessionService.getUserProfileImage(), '/images/profile.jpg');
      });

      test('should not save profile picture when not provided', () async {
        await userSessionService.saveUserSession(
          userId: 'user-123',
          email: 'john@example.com',
          username: 'johndoe',
          firstName: 'John',
          lastName: 'Doe',
        );

        expect(userSessionService.getUserProfileImage(), null);
      });
    });

    // ── clearSession ─────────────────────────────────────────────
    group('clearSession', () {
      test('should clear all session data', () async {
        await userSessionService.saveUserSession(
          userId: 'user-123',
          email: 'john@example.com',
          username: 'johndoe',
          firstName: 'John',
          lastName: 'Doe',
        );

        await userSessionService.clearSession();

        expect(userSessionService.isLoggedIn(), false);
        expect(userSessionService.getUserId(), null);
        expect(userSessionService.getUserEmail(), null);
        expect(userSessionService.getUsername(), null);
        expect(userSessionService.getUserFirstName(), null);
        expect(userSessionService.getUserLastName(), null);
        expect(userSessionService.getUserProfileImage(), null);
      });
    });

    // ── getters before login ──────────────────────────────────────
    group('getters before any session saved', () {
      test('isLoggedIn should return false by default', () {
        expect(userSessionService.isLoggedIn(), false);
      });

      test('getUserId should return null by default', () {
        expect(userSessionService.getUserId(), null);
      });

      test('getUserEmail should return null by default', () {
        expect(userSessionService.getUserEmail(), null);
      });

      test('getUsername should return null by default', () {
        expect(userSessionService.getUsername(), null);
      });

      test('getUserFirstName should return null by default', () {
        expect(userSessionService.getUserFirstName(), null);
      });

      test('getUserLastName should return null by default', () {
        expect(userSessionService.getUserLastName(), null);
      });

      test('getUserProfileImage should return null by default', () {
        expect(userSessionService.getUserProfileImage(), null);
      });
    });

    // ── overwrite session ─────────────────────────────────────────
    group('overwrite session', () {
      test('should overwrite existing session with new data', () async {
        await userSessionService.saveUserSession(
          userId: 'user-123',
          email: 'old@example.com',
          username: 'olduser',
          firstName: 'Old',
          lastName: 'User',
        );

        await userSessionService.saveUserSession(
          userId: 'user-456',
          email: 'new@example.com',
          username: 'newuser',
          firstName: 'New',
          lastName: 'User',
        );

        expect(userSessionService.getUserId(), 'user-456');
        expect(userSessionService.getUserEmail(), 'new@example.com');
        expect(userSessionService.getUsername(), 'newuser');
        expect(userSessionService.getUserFirstName(), 'New');
      });
    });
  });
}