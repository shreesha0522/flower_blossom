import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashState {
  final bool isNavigating;
  const SplashState({this.isNavigating = false});

  SplashState copyWith({bool? isNavigating}) {
    return SplashState(isNavigating: isNavigating ?? this.isNavigating);
  }
}

final splashViewModelProvider =
    NotifierProvider<SplashViewModel, SplashState>(SplashViewModel.new);

class SplashViewModel extends Notifier<SplashState> {
  @override
  SplashState build() {
    return const SplashState();
  }

  Future<void> startSplashTimer(Function onComplete) async {
    await Future.delayed(const Duration(seconds: 3));
    state = state.copyWith(isNavigating: true);
    onComplete();
  }
}