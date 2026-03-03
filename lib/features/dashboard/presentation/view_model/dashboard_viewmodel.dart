import 'package:flower_blossom/features/cart/data/cart_hive_model.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';
import 'package:flower_blossom/core/services/hive/hive_service.dart';
import 'package:flower_blossom/core/services/storage/user_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State
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

// ViewModel
final dashboardViewModelProvider =
    NotifierProvider<DashboardViewModel, DashboardState>(
        DashboardViewModel.new);

class DashboardViewModel extends Notifier<DashboardState> {
  late final UserSessionService _userSessionService;
  late final HiveService _hiveService;

  @override
  DashboardState build() {
    _userSessionService = ref.read(userSessionServiceProvider);
    _hiveService = ref.read(hiveServiceProvider);
    _loadUserAndCart();
    return const DashboardState();
  }

  Future<void> _loadUserAndCart() async {
    // Load user from session
    final firstName = _userSessionService.getUserFirstName() ?? 'Guest';
    final lastName = _userSessionService.getUserLastName() ?? 'User';
    final username = _userSessionService.getUsername() ?? 'guest';
    final email = _userSessionService.getUserEmail() ?? 'guest@example.com';

    // Load cart from Hive
    final savedCart = _hiveService.getCartItems();
    final cartItems = savedCart.map((e) => e.toCartItem()).toList();

    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      cartItems: cartItems,
    );
  }

  void setIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  Future<void> addToCart(CartItem item) async {
    final updatedCart = [...state.cartItems, item];
    state = state.copyWith(cartItems: updatedCart);
    // Persist to Hive
    await _hiveService.saveCartItems(
      updatedCart.map((e) => CartItemHiveModel.fromCartItem(e)).toList(),
    );
  }
}
