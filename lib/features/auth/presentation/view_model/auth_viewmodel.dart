import 'package:flower_blossom/features/auth/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/login_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/logout_usecase.dart';
import 'package:flower_blossom/features/auth/domain/usecase/register_usecase.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod provider for AuthViewModel
final authViewModelProvider =
    NotifierProvider<AuthViewModel, AuthState>(AuthViewModel.new);

class AuthViewModel extends Notifier<AuthState> {
  late final RegisterUsecase _registerUsecase;
  late final LoginUsecase _loginUsecase;
  late final LogoutUsecase _logoutUsecase;
  late final GetCurrentUserUsecase _getCurrentUserUsecase;

  @override
  AuthState build() {
    // inject dependencies via Riverpod providers
    _registerUsecase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUseCaseProvider);
    _logoutUsecase = ref.read(logoutUsecaseProvider);
    _getCurrentUserUsecase = ref.read(getCurrentUserUsecaseProvider);

    return AuthState.initial();
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = AuthState.loading();

    final params = RegisterUsecaseParams(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    final result = await _registerUsecase(params);
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = AuthState.registered("Registration successful"),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();

    final params = LoginUsecaseParams(
      email: email,
      password: password,
    );

    final result = await _loginUsecase(params);
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (entity) => state = AuthState.authenticated(entity),
    );
  }

  Future<void> logout() async {
    state = AuthState.loading();

    final result = await _logoutUsecase();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState(status: AuthStatus.unauthenticated),
    );
  }

  Future<void> getCurrentUser() async {
    state = AuthState.loading();

    final result = await _getCurrentUserUsecase();
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (entity) => state = AuthState.authenticated(entity),
    );
  }
}