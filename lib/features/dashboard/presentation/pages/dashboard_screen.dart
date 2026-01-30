import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/about_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/cart_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/bottom_screen/profile_screen.dart';
import 'package:flower_blossom/core/utils/user_storage.dart';
import 'package:flutter/material.dart';
import 'bottom_screen/home_screen.dart';
import '../../../cart/presentation/cart_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];
  late final List<Widget> _bottomScreens;

  @override
  void initState() {
    super.initState();
    
    // Get current user data from UserStorage
    final currentUser = UserStorage.getCurrentUser();
    
    _bottomScreens = [
      HomeScreen(
        onAddToCart: (CartItem item) {
          setState(() {
            _cartItems.add(item);
          });
        },
      ),
      CartScreen(cartItems: _cartItems),
      // ✅ Profile Screen with real user data
      ProfileScreen(
        fullName: currentUser?.fullName ?? 'Guest User',
        username: currentUser?.username ?? 'guest',
        email: currentUser?.email ?? 'guest@example.com',
        password: currentUser?.password ?? '',
      ),
      AboutScreen(userName: currentUser?.fullName ?? 'Guest User'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex == 0 ||
              _selectedIndex == 1 ||
              _selectedIndex == 3)
          ? AppBar(
              title: Text(_getTitle(_selectedIndex)),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 229, 128, 162),
            )
          : null,
      body: _bottomScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 229, 128, 162),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Cart';
      case 3:
        return 'About';
      default:
        return '';
    }
  }
}