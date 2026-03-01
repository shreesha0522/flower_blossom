import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/core/utils/user_storage.dart';

void main() {
  group('UserStorage', () {

    // Clear user before each test
    setUp(() {
      UserStorage.clearUser();
    });

    // Test 1: Should register a user correctly
    test('should register a user with all fields', () {
      // Act
      UserStorage.register(
        firstName: 'John',
        lastName: 'Doe',
        username: 'johndoe',
        email: 'john@example.com',
        password: 'password123',
      );

      // Assert
      final user = UserStorage.getCurrentUser();
      expect(user, isNotNull);
      expect(user!.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.username, 'johndoe');
      expect(user.email, 'john@example.com');
      expect(user.password, 'password123');
    });

    // Test 2: Should return null when no user registered
    test('should return null when no user is registered', () {
      // Assert
      expect(UserStorage.getCurrentUser(), isNull);
    });

    // Test 3: Should clear user correctly
    test('should clear user data on clearUser()', () {
      // Arrange
      UserStorage.register(
        firstName: 'John',
        lastName: 'Doe',
        username: 'johndoe',
        email: 'john@example.com',
        password: 'password123',
      );

      // Act
      UserStorage.clearUser();

      // Assert
      expect(UserStorage.getCurrentUser(), isNull);
    });

    // Test 4: Static getters should return correct values
    test('static getters should return correct user values', () {
      // Arrange
      UserStorage.register(
        firstName: 'Jane',
        lastName: 'Smith',
        username: 'janesmith',
        email: 'jane@example.com',
        password: 'password456',
      );

      // Assert
      expect(UserStorage.firstName, 'Jane');
      expect(UserStorage.lastName, 'Smith');
      expect(UserStorage.username, 'janesmith');
      expect(UserStorage.email, 'jane@example.com');
      expect(UserStorage.password, 'password456');
    });

    // Test 5: Static getters should return null when no user
    test('static getters should return null when no user registered', () {
      // Assert
      expect(UserStorage.firstName, isNull);
      expect(UserStorage.lastName, isNull);
      expect(UserStorage.username, isNull);
      expect(UserStorage.email, isNull);
      expect(UserStorage.password, isNull);
    });

  });
}