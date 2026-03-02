import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flower_blossom/core/error/failures.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_blossom/features/auth/domain/repositories/auth_repository.dart';
import 'package:flower_blossom/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/register_usecase.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

const testEntity = AuthEntity(
  authId: 'user-123',
  firstName: 'John',
  lastName: 'Doe',
  username: 'johndoe',
  email: 'john@example.com',
  password: 'password123',
);

void main() {
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const AuthEntity(
      firstName: '', lastName: '', username: '', email: '',
    ));
  });

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('LoginUsecase', () {
    late LoginUsecase usecase;
    setUp(() => usecase = LoginUsecase(authRepository: mockRepository));

    const params = LoginUsecaseParams(
      email: 'john@example.com', password: 'password123',
    );

    test('should return AuthEntity on successful login', () async {
      when(() => mockRepository.login(any(), any()))
          .thenAnswer((_) async => const Right(testEntity));
      final result = await usecase(params);
      expect(result, isA<Right>());
      result.fold((l) => fail('Expected Right'), (r) => expect(r.email, 'john@example.com'));
    });

    test('should return Failure on failed login', () async {
      when(() => mockRepository.login(any(), any()))
          .thenAnswer((_) async => Left(ApiFailure(message: 'Invalid credentials')));
      final result = await usecase(params);
      expect(result, isA<Left>());
      result.fold((l) => expect(l.message, 'Invalid credentials'), (r) => fail('Expected Left'));
    });

    test('LoginUsecaseParams props should be correct', () {
      const p = LoginUsecaseParams(email: 'john@example.com', password: 'password123');
      expect(p.props, [p.email, p.password]);
    });
  });

  group('LogoutUsecase', () {
    late LogoutUsecase usecase;
    setUp(() => usecase = LogoutUsecase(authRepository: mockRepository));

    test('should return true on successful logout', () async {
      when(() => mockRepository.logout()).thenAnswer((_) async => const Right(true));
      final result = await usecase();
      expect(result, isA<Right>());
      result.fold((l) => fail('Expected Right'), (r) => expect(r, true));
    });

    test('should return Failure on failed logout', () async {
      when(() => mockRepository.logout())
          .thenAnswer((_) async => Left(LocalDataBaseFailure(message: 'Failed to logout')));
      final result = await usecase();
      expect(result, isA<Left>());
      result.fold((l) => expect(l.message, 'Failed to logout'), (r) => fail('Expected Left'));
    });
  });

  group('RegisterUsecase', () {
    late RegisterUsecase usecase;
    setUp(() => usecase = RegisterUsecase(authRepository: mockRepository));

    const params = RegisterUsecaseParams(
      firstName: 'John', lastName: 'Doe', email: 'john@example.com',
      username: 'johndoe', password: 'password123', confirmPassword: 'password123',
    );

    test('should return true on successful registration', () async {
      when(() => mockRepository.register(any())).thenAnswer((_) async => const Right(true));
      final result = await usecase(params);
      expect(result, isA<Right>());
      result.fold((l) => fail('Expected Right'), (r) => expect(r, true));
    });

    test('should return Failure on failed registration', () async {
      when(() => mockRepository.register(any()))
          .thenAnswer((_) async => Left(ApiFailure(message: 'Email already exists')));
      final result = await usecase(params);
      expect(result, isA<Left>());
      result.fold((l) => expect(l.message, 'Email already exists'), (r) => fail('Expected Left'));
    });

    test('RegisterUsecaseParams props should be correct', () {
      expect(params.props, ['John', 'Doe', 'john@example.com', 'johndoe', 'password123', 'password123']);
    });
  });

  group('AuthState', () {
    test('initial state should have AuthStatus.initial', () {
      final state = AuthState.initial();
      expect(state.status, AuthStatus.initial);
      expect(state.entity, null);
      expect(state.errorMessage, null);
    });

    test('loading state should have AuthStatus.loading', () {
      final state = AuthState.loading();
      expect(state.status, AuthStatus.loading);
    });

    test('authenticated state should have entity', () {
      final state = AuthState.authenticated(testEntity);
      expect(state.status, AuthStatus.authenticated);
      expect(state.entity?.email, 'john@example.com');
    });

    test('error state should have error message', () {
      final state = AuthState.error('Something went wrong');
      expect(state.status, AuthStatus.error);
      expect(state.errorMessage, 'Something went wrong');
    });

    test('registered state should have success message', () {
      final state = AuthState.registered('Registration successful');
      expect(state.status, AuthStatus.registered);
      expect(state.successMessage, 'Registration successful');
    });

    test('copyWith should update only provided fields', () {
      final state = AuthState.initial();
      final updated = state.copyWith(status: AuthStatus.loading);
      expect(updated.status, AuthStatus.loading);
      expect(updated.entity, null);
    });

    test('copyWith with clearMessage should clear messages', () {
      final state = AuthState.error('Some error');
      final updated = state.copyWith(clearMessage: true);
      expect(updated.errorMessage, null);
    });

    test('two identical states should be equal', () {
      expect(AuthState.initial(), equals(AuthState.initial()));
    });
  });
}
