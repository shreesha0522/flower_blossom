// lib/features/auth/domain/usecases/login_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flower_blossom/core/error/failures.dart';
import 'package:flower_blossom/core/services/usecases/app_usecases.dart';
import 'package:flower_blossom/features/auth/data/repositories/auth_repository.dart';
import 'package:flower_blossom/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_blossom/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final loginUseCaseProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUsecase(authRepository: authRepository);
});

/// Parameters for login use case
class LoginUsecaseParams extends Equatable {
  final String email;
  final String password;

  const LoginUsecaseParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Login use case implementation
class LoginUsecase
    implements UseCaseWithParams<AuthEntity, LoginUsecaseParams> {
  final IAuthRepository _authRepository;

  LoginUsecase({required IAuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthEntity>> call(LoginUsecaseParams params) {
    return _authRepository.login(params.email, params.password);
  }
}