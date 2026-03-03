import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int currentPage;
  final bool isComplete;

  const OnboardingState({
    this.currentPage = 0,
    this.isComplete = false,
  });

  OnboardingState copyWith({int? currentPage, bool? isComplete}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

final onboardingViewModelProvider =
    NotifierProvider<OnboardingViewModel, OnboardingState>(
        OnboardingViewModel.new);

class OnboardingViewModel extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  void nextPage() {
    state = state.copyWith(currentPage: state.currentPage + 1);
  }

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void completeOnboarding() {
    state = state.copyWith(isComplete: true);
  }
}
