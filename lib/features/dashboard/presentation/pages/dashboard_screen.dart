import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/about_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/cart_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/profile_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/view_model/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bottom_screen/home_screen.dart';
import '../../../cart/presentation/cart_item.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardViewModelProvider);
    final viewModel = ref.read(dashboardViewModelProvider.notifier);

    final screens = [
      HomeScreen(
        onAddToCart: (CartItem item) => viewModel.addToCart(item),
      ),
      CartScreen(),
      ProfileScreen(
        firstName: state.firstName,
        lastName: state.lastName,
        username: state.username,
        email: state.email,
        password: '',
      ),
      AboutScreen(userName: state.firstName),
    ];

    return Scaffold(
      appBar: (state.selectedIndex == 0 ||
              state.selectedIndex == 1 ||
              state.selectedIndex == 3)
          ? AppBar(
              title: Text(_getTitle(state.selectedIndex)),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 229, 128, 162),
            )
          : null,
      body: screens[state.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: state.selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 229, 128, 162),
        unselectedItemColor: Colors.grey,
        onTap: (index) => viewModel.setIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0: return 'Home';
      case 1: return 'Cart';
      case 3: return 'About';
      default: return '';
    }
  }
}
