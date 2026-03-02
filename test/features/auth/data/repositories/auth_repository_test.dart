import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flower_blossom/features/auth/data/datasources/auth_datsource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flower_blossom/core/error/failures.dart';
import 'package:flower_blossom/core/services/connectivity/network_info.dart';
import 'package:flower_blossom/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:flower_blossom/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flower_blossom/features/auth/data/models/auth_api_model.dart';
import 'package:flower_blossom/features/auth/data/models/auth_hive_model.dart';
import 'package:flower_blossom/features/auth/data/repositories/auth_repository.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';

// Mocks
class MockAuthLocalDatasource extends Mock implements IAuthLocalDatasource {}
class MockAuthRemoteDatasource extends Mock implements IAuthRemoteDatasource {}
class MockNetworkInfo extends Mock implements INetworkInfo {}

// ✅ Fakes for registerFallbackValue
class FakeAuthApiModel extends Fake implements AuthApiModel {}
class FakeAuthHiveModel extends Fake implements AuthHiveModel {}

void main() {
  late AuthRepository repository;
  late MockAuthLocalDatasource mockLocalDatasource;
  late MockAuthRemoteDatasource mockRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;

  // ✅ Register fallback values before any test runs
  setUpAll(() {
    registerFallbackValue(FakeAuthApiModel());
    registerFallbackValue(FakeAuthHiveModel());
  });

  setUp(() {
    mockLocalDatasource = MockAuthLocalDatasource();
    mockRemoteDatasource = MockAuthRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepository(
      authLocalDatasource: mockLocalDatasource,
      authRemoteDatasource: mockRemoteDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  const testEntity = AuthEntity(
    authId: 'user-123',
    firstName: 'John',
    lastName: 'Doe',
    username: 'johndoe',
    email: 'john@example.com',
    password: 'password123',
    confirmPassword: 'password123',
  );

  final testApiModel = AuthApiModel(
    authId: 'user-123',
    firstName: 'John',
    lastName: 'Doe',
    username: 'johndoe',
    email: 'john@example.com',
  );

  final testHiveModel = AuthHiveModel(
    authId: 'user-123',
    firstName: 'John',
    lastName: 'Doe',
    username: 'johndoe',
    email: 'john@example.com',
    password: 'password123',
  );

  // ── LOGIN ─────────────────────────────────────────────────────
  group('login', () {
    group('when online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return AuthEntity on successful remote login', () async {
        when(() => mockRemoteDatasource.login(any(), any()))
            .thenAnswer((_) async => testApiModel);

        final result = await repository.login('john@example.com', 'password123');

        expect(result, isA<Right>());
        result.fold(
          (l) => fail('Expected Right'),
          (r) => expect(r.email, 'john@example.com'),
        );
      });

      test('should return ApiFailure when remote login returns null', () async {
        when(() => mockRemoteDatasource.login(any(), any()))
            .thenAnswer((_) async => null);

        final result = await repository.login('john@example.com', 'wrong');

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<ApiFailure>()),
          (r) => fail('Expected Left'),
        );
      });

      test('should return ApiFailure on DioException', () async {
        when(() => mockRemoteDatasource.login(any(), any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {"message": "Invalid credentials"},
              statusCode: 401,
            ),
          ),
        );

        final result = await repository.login('john@example.com', 'wrong');

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l.message, 'Invalid credentials'),
          (r) => fail('Expected Left'),
        );
      });

      test('should return ApiFailure on general exception', () async {
        when(() => mockRemoteDatasource.login(any(), any()))
            .thenThrow(Exception('Unexpected error'));

        final result = await repository.login('john@example.com', 'password123');

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<ApiFailure>()),
          (r) => fail('Expected Left'),
        );
      });
    });

    group('when offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return AuthEntity from local datasource', () async {
        when(() => mockLocalDatasource.login(any(), any()))
            .thenAnswer((_) async => testHiveModel);

        final result = await repository.login('john@example.com', 'password123');

        expect(result, isA<Right>());
        result.fold(
          (l) => fail('Expected Right'),
          (r) => expect(r.email, 'john@example.com'),
        );
      });

      test('should return LocalFailure when local login returns null', () async {
        when(() => mockLocalDatasource.login(any(), any()))
            .thenAnswer((_) async => null);

        final result = await repository.login('john@example.com', 'wrong');

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<LocalDataBaseFailure>()),
          (r) => fail('Expected Left'),
        );
      });

      test('should return LocalFailure on exception', () async {
        when(() => mockLocalDatasource.login(any(), any()))
            .thenThrow(Exception('DB error'));

        final result = await repository.login('john@example.com', 'password123');

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<LocalDataBaseFailure>()),
          (r) => fail('Expected Left'),
        );
      });
    });
  });

  // ── LOGOUT ────────────────────────────────────────────────────
  group('logout', () {
    test('should return true on successful logout', () async {
      when(() => mockLocalDatasource.logout()).thenAnswer((_) async => true);

      final result = await repository.logout();

      expect(result, isA<Right>());
      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r, true),
      );
    });

    test('should return LocalFailure when logout returns false', () async {
      when(() => mockLocalDatasource.logout()).thenAnswer((_) async => false);

      final result = await repository.logout();

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<LocalDataBaseFailure>()),
        (r) => fail('Expected Left'),
      );
    });

    test('should return LocalFailure on exception', () async {
      when(() => mockLocalDatasource.logout()).thenThrow(Exception('DB error'));

      final result = await repository.logout();

      expect(result, isA<Left>());
      result.fold(
        (l) => expect(l, isA<LocalDataBaseFailure>()),
        (r) => fail('Expected Left'),
      );
    });
  });

  // ── REGISTER ──────────────────────────────────────────────────
  group('register', () {
    group('when online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return true on successful remote register', () async {
        when(() => mockRemoteDatasource.register(any()))
            .thenAnswer((_) async => testApiModel);

        final result = await repository.register(testEntity);

        expect(result, isA<Right>());
        result.fold(
          (l) => fail('Expected Right'),
          (r) => expect(r, true),
        );
      });

      test('should return ApiFailure on DioException during register', () async {
        when(() => mockRemoteDatasource.register(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {"message": "Email already exists"},
              statusCode: 400,
            ),
          ),
        );

        final result = await repository.register(testEntity);

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l.message, 'Email already exists'),
          (r) => fail('Expected Left'),
        );
      });

      test('should return ApiFailure on general exception during register',
          () async {
        when(() => mockRemoteDatasource.register(any()))
            .thenThrow(Exception('Unexpected'));

        final result = await repository.register(testEntity);

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<ApiFailure>()),
          (r) => fail('Expected Left'),
        );
      });
    });

    group('when offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return true on successful local register', () async {
        when(() => mockLocalDatasource.register(any()))
            .thenAnswer((_) async => true);

        final result = await repository.register(testEntity);

        expect(result, isA<Right>());
        result.fold(
          (l) => fail('Expected Right'),
          (r) => expect(r, true),
        );
      });

      test('should return LocalFailure when local register returns false',
          () async {
        when(() => mockLocalDatasource.register(any()))
            .thenAnswer((_) async => false);

        final result = await repository.register(testEntity);

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<LocalDataBaseFailure>()),
          (r) => fail('Expected Left'),
        );
      });

      test('should return LocalFailure on exception during local register',
          () async {
        when(() => mockLocalDatasource.register(any()))
            .thenThrow(Exception('DB error'));

        final result = await repository.register(testEntity);

        expect(result, isA<Left>());
        result.fold(
          (l) => expect(l, isA<LocalDataBaseFailure>()),
          (r) => fail('Expected Left'),
        );
      });
    });
  });
}