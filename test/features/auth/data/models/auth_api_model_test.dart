import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/auth/data/models/auth_api_model.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

void main() {
  group('AuthApiModel', () {

    // Test 1: toJson should convert AuthApiModel to Map with correct keys
    test('toJson should convert model to JSON with backend expected keys', () {
      // Arrange
      final model = AuthApiModel(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        confirmPassword: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['firstName'], 'John');
      expect(json['lastName'], 'Doe');
      expect(json['email'], 'john@example.com');
      expect(json['username'], 'johndoe');
      expect(json['password'], 'password123');
      expect(json['confirmPassword'], 'password123');
      expect(json['profilePicture'], 'https://example.com/pic.jpg');
      expect(json.containsKey('authId'), false);
    });

    // Test 2: fromJson should create AuthApiModel from backend response
    test('fromJson should parse backend JSON response correctly', () {
      // Arrange - Simulating backend response
      final json = {
        '_id': '123',
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john@example.com',
        'username': 'johndoe',
        'profilePicture': 'https://example.com/pic.jpg',
      };

      // Act
      final model = AuthApiModel.fromJson(json);

      // Assert
      expect(model.authId, '123');
      expect(model.firstName, 'John');
      expect(model.lastName, 'Doe');
      expect(model.email, 'john@example.com');
      expect(model.username, 'johndoe');
      expect(model.profilePicture, 'https://example.com/pic.jpg');
      expect(model.password, null);
      expect(model.confirmPassword, null);
    });

    // Test 3: fromJson should fallback to empty string if firstName/lastName missing
    test('fromJson should use empty string when firstName or lastName is null', () {
      // Arrange - Backend response without name fields
      final json = {
        '_id': '123',
        'email': 'john@example.com',
        'username': 'johndoe',
      };

      // Act
      final model = AuthApiModel.fromJson(json);

      // Assert
      expect(model.firstName, '');
      expect(model.lastName, '');
      expect(model.username, 'johndoe');
    });

    // Test 4: toEntity should convert AuthApiModel to AuthEntity
    test('toEntity should convert model to domain entity', () {
      // Arrange
      final model = AuthApiModel(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        confirmPassword: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity, isA<AuthEntity>());
      expect(entity.authId, '123');
      expect(entity.firstName, 'John');
      expect(entity.lastName, 'Doe');
      expect(entity.email, 'john@example.com');
      expect(entity.username, 'johndoe');
      expect(entity.confirmPassword, 'password123');
      expect(entity.profilePicture, 'https://example.com/pic.jpg');
    });

    // Test 5: fromEntity should convert AuthEntity to AuthApiModel
    test('fromEntity should convert domain entity to model', () {
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

      // Act
      final model = AuthApiModel.fromEntity(entity);

      // Assert
      expect(model, isA<AuthApiModel>());
      expect(model.authId, '123');
      expect(model.firstName, 'John');
      expect(model.lastName, 'Doe');
      expect(model.email, 'john@example.com');
      expect(model.username, 'johndoe');
      expect(model.password, 'password123');
      expect(model.confirmPassword, 'password123');
      expect(model.profilePicture, 'https://example.com/pic.jpg');
    });

  });
}