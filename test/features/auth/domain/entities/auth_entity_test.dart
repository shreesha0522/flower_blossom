import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

void main() {
  group('AuthEntity', () {

    // Test 1: Should create AuthEntity with all required fields
    test('should create AuthEntity with all fields correctly', () {
      // Arrange & Act
      const entity = AuthEntity(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        confirmPassword: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Assert
      expect(entity.authId, '123');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.email, 'john@example.com');
      expect(entity.username, 'johndoe');
      expect(entity.password, 'password123');
      expect(entity.confirmPassword, 'password123');
      expect(entity.profilePicture, 'https://example.com/pic.jpg');
    });

    // Test 2: Should create AuthEntity with only required fields
    test('should create AuthEntity with only required fields', () {
      // Arrange & Act
      const entity = AuthEntity(
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        username: 'janesmith',
      );

      // Assert
      expect(entity.firstName, 'Jane');
      expect(entity.lastName, 'Smith');
      expect(entity.email, 'jane@example.com');
      expect(entity.username, 'janesmith');
      expect(entity.authId, null);
      expect(entity.password, null);
      expect(entity.confirmPassword, null);
      expect(entity.profilePicture, null);
    });

    // Test 3: Two entities with same values should be equal
    test('should be equal when all fields are the same', () {
      // Arrange
      const entity1 = AuthEntity(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
      );

      const entity2 = AuthEntity(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
      );

      // Assert
      expect(entity1, equals(entity2));
    });

    // Test 4: Two entities with different values should not be equal
    test('should not be equal when fields are different', () {
      // Arrange
      const entity1 = AuthEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
      );

      const entity2 = AuthEntity(
        firstName: 'Jane',
        lastName: 'Smith',
        email: 'jane@example.com',
        username: 'janesmith',
      );

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });

    // Test 5: Props should contain all fields
    test('should have correct props list', () {
      // Arrange
      const entity = AuthEntity(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        confirmPassword: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Assert
      expect(entity.props, [
        '123',
        'John',
        'Doe',
        'john@example.com',
        'johndoe',
        'password123',
        'password123',
        'https://example.com/pic.jpg',
      ]);
    });

  });
}