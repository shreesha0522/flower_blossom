import 'package:flower_blossom/features/cart/presentation/view_model/cart_viewmodel.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';
import 'package:flower_blossom/core/services/hive/hive_service.dart';
import 'package:flower_blossom/core/services/storage/user_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardState {
  final int selectedIndex;
  final List<CartItem> cartItems;
  final String firstName;
  final String lastName;
  final String username;
  final String email;

  const DashboardState({
    this.selectedIndex = 0,
    this.cartItems = const [],
    this.firstName = 'Guest',
    this.lastName = 'User',
    this.username = 'guest',
    this.email = 'guest@example.com',
  });

  DashboardState copyWith({
    int? selectedIndex,
    List<CartItem>? cartItems,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
  }) {
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      cartItems: cartItems ?? this.cartItems,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }
}

final dashboardViewModelProvider =
    NotifierProvider<DashboardViewModel, DashboardState>(DashboardViewModel.new);

class DashboardViewModel extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    _loadUserAndCart();
    return const DashboardState();
  }

  Future<void> _loadUserAndCart() async {
    try {
      final userSessionService = ref.read(userSessionServiceProvider);
      final hiveService = ref.read(hiveServiceProvider);

      final firstName = userSessionService.getUserFirstName() ?? 'Guest';
      final lastName = userSessionService.getUserLastName() ?? 'User';
      final username = userSessionService.getUsername() ?? 'guest';
      final email = userSessionService.getUserEmail() ?? 'guest@example.com';

      List<CartItem> cartItems = [];
      try {
        final saved = hiveService.getCartItems();
        cartItems = saved.map((e) => e.toCartItem()).toList();
      } catch (e) {
        cartItems = [];
      }

      state = state.copyWith(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        cartItems: cartItems,
      );
    } catch (e) {
      // providers not initialized in tests - use defaults
    }
  }

  void setIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  Future<void> addToCart(CartItem item) async {
    // ✅ Delegate to CartViewModel so CartScreen updates
    await ref.read(cartViewModelProvider.notifier).addItem(item);
  }
}
