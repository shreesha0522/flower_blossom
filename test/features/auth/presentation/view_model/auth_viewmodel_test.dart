import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flower_blossom/core/error/failures.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_blossom/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/register_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_blossom/features/auth/domain/repositories/auth_repository.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';
import 'package:flower_blossom/features/auth/presentation/view_model/auth_viewmodel.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

const testEntity = AuthEntity(
  authId: 'user-123', firstName: 'John', lastName: 'Doe',
  username: 'johndoe', email: 'john@example.com', password: 'password123',
);

void main() {
  late MockAuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const AuthEntity(firstName: '', lastName: '', username: '', email: ''));
    registerFallbackValue(const LoginUsecaseParams(email: '', password: ''));
    registerFallbackValue(const RegisterUsecaseParams(firstName: '', lastName: '', email: '', username: '', password: '', confirmPassword: ''));
  });

  setUp(() { mockRepository = MockAuthRepository(); });

  ProviderContainer makeContainer() {
    return ProviderContainer(overrides: [
      loginUseCaseProvider.overrideWithValue(LoginUsecase(authRepository: mockRepository)),
      logoutUsecaseProvider.overrideWithValue(LogoutUsecase(authRepository: mockRepository)),
      registerUsecaseProvider.overrideWithValue(RegisterUsecase(authRepository: mockRepository)),
      getCurrentUserUsecaseProvider.overrideWithValue(GetCurrentUserUsecase(authRepository: mockRepository)),
    ]);
  }

  group('AuthViewModel', () {
    test('initial state should be AuthStatus.initial', () {
      final c = makeContainer();
      expect(c.read(authViewModelProvider).status, AuthStatus.initial);
      c.dispose();
    });

    test('login success sets authenticated state', () async {
      when(() => mockRepository.login(any(), any())).thenAnswer((_) async => const Right(testEntity));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).login(email: 'john@example.com', password: 'password123');
      expect(c.read(authViewModelProvider).status, AuthStatus.authenticated);
      expect(c.read(authViewModelProvider).entity?.email, 'john@example.com');
      c.dispose();
    });

    test('login failure sets error state', () async {
      when(() => mockRepository.login(any(), any())).thenAnswer((_) async => Left(ApiFailure(message: 'Invalid credentials')));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).login(email: 'john@example.com', password: 'wrong');
      expect(c.read(authViewModelProvider).status, AuthStatus.error);
      expect(c.read(authViewModelProvider).errorMessage, 'Invalid credentials');
      c.dispose();
    });

    test('logout success sets unauthenticated state', () async {
      when(() => mockRepository.logout()).thenAnswer((_) async => const Right(true));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).logout();
      expect(c.read(authViewModelProvider).status, AuthStatus.unauthenticated);
      c.dispose();
    });

    test('logout failure sets error state', () async {
      when(() => mockRepository.logout()).thenAnswer((_) async => Left(LocalDataBaseFailure(message: 'Logout failed')));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).logout();
      expect(c.read(authViewModelProvider).status, AuthStatus.error);
      c.dispose();
    });

    test('register success sets registered state', () async {
      when(() => mockRepository.register(any())).thenAnswer((_) async => const Right(true));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).register(firstName: 'John', lastName: 'Doe', username: 'johndoe', email: 'john@example.com', password: 'password123', confirmPassword: 'password123');
      expect(c.read(authViewModelProvider).status, AuthStatus.registered);
      c.dispose();
    });

    test('register failure sets error state', () async {
      when(() => mockRepository.register(any())).thenAnswer((_) async => Left(ApiFailure(message: 'Email exists')));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).register(firstName: 'John', lastName: 'Doe', username: 'johndoe', email: 'john@example.com', password: 'password123', confirmPassword: 'password123');
      expect(c.read(authViewModelProvider).status, AuthStatus.error);
      c.dispose();
    });

    test('getCurrentUser success sets authenticated state', () async {
      when(() => mockRepository.getCurrentUser()).thenAnswer((_) async => const Right(testEntity));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).getCurrentUser();
      expect(c.read(authViewModelProvider).status, AuthStatus.authenticated);
      c.dispose();
    });

    test('getCurrentUser failure sets error state', () async {
      when(() => mockRepository.getCurrentUser()).thenAnswer((_) async => Left(ApiFailure(message: 'Not found')));
      final c = makeContainer();
      await c.read(authViewModelProvider.notifier).getCurrentUser();
      expect(c.read(authViewModelProvider).status, AuthStatus.error);
      c.dispose();
    });
  });
}
