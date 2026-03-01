import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/auth/data/models/auth_hive_model.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

void main() {
  group('AuthHiveModel', () {

    // Test 1: Should create AuthHiveModel with all fields
    test('should create AuthHiveModel with all fields correctly', () {
      // Arrange & Act
      final model = AuthHiveModel(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Assert
      expect(model.authId, '123');
      expect(model.firstName, 'John');
      expect(model.lastName, 'Doe');
      expect(model.email, 'john@example.com');
      expect(model.username, 'johndoe');
      expect(model.password, 'password123');
      expect(model.profilePicture, 'https://example.com/pic.jpg');
    });

    // Test 2: Should auto-generate authId when not provided
    test('should auto-generate authId when not provided', () {
      // Arrange & Act
      final model = AuthHiveModel(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
      );

      // Assert
      expect(model.authId, isNotNull);
      expect(model.authId, isNotEmpty);
    });

    // Test 3: toEntity should convert HiveModel to AuthEntity correctly
    test('toEntity should convert HiveModel to AuthEntity correctly', () {
      // Arrange
      final model = AuthHiveModel(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
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
      expect(entity.password, 'password123');
      expect(entity.profilePicture, 'https://example.com/pic.jpg');
    });

    // Test 4: fromEntity should convert AuthEntity to HiveModel correctly
    test('fromEntity should convert AuthEntity to HiveModel correctly', () {
      // Arrange
      const entity = AuthEntity(
        authId: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        username: 'johndoe',
        password: 'password123',
        profilePicture: 'https://example.com/pic.jpg',
      );

      // Act
      final model = AuthHiveModel.fromEntity(entity);

      // Assert
      expect(model, isA<AuthHiveModel>());
      expect(model.authId, '123');
      expect(model.firstName, 'John');
      expect(model.lastName, 'Doe');
      expect(model.email, 'john@example.com');
      expect(model.username, 'johndoe');
      expect(model.password, 'password123');
      expect(model.profilePicture, 'https://example.com/pic.jpg');
    });

    // Test 5: toEntityList should convert list of HiveModels to list of entities
    test('toEntityList should convert list of models to list of entities', () {
      // Arrange
      final models = [
        AuthHiveModel(
          authId: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          username: 'johndoe',
        ),
        AuthHiveModel(
          authId: '2',
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          username: 'janesmith',
        ),
      ];

      // Act
      final entities = AuthHiveModel.toEntityList(models);

      // Assert
      expect(entities.length, 2);
      expect(entities[0].firstName, 'John');
      expect(entities[0].lastName, 'Doe');
      expect(entities[1].firstName, 'Jane');
      expect(entities[1].lastName, 'Smith');
    });

  });
}