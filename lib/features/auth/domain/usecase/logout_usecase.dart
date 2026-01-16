import 'package:dartz/dartz.dart';
import 'package:flower_blossom/core/error/failures.dart';
import 'package:flower_blossom/features/auth/data/repositories/auth_repository.dart' as data_repo;
import 'package:flower_blossom/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final logoutUsecaseProvider = Provider<LogoutUsecase>((ref) {
	final authRepository = ref.watch(data_repo.authRepositoryProvider);
	return LogoutUsecase(authRepository: authRepository);
});

/// Logout use case implementation
class LogoutUsecase {
	final IAuthRepository _authRepository;

	LogoutUsecase({required IAuthRepository authRepository})
			: _authRepository = authRepository;

	Future<Either<Failure, bool>> call() {
		return _authRepository.logout();
	}
}