import 'package:flutter/material.dart';
import 'bottomscreen/home_screen.dart';
// import 'bottomscreen/cart_screen.dart';
// import 'bottomscreen/profile_screen.dart';
// import 'bottomscreen/about_screen.dart';
import '/models/cart_item.dart';
import 'checkout_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String address;

  const DashboardScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
  });

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

    _bottomScreens = [
      HomeScreen(
        onAddToCart: (CartItem item) {
          setState(() {
            _cartItems.add(item);
          });
        },
      ),

      // CartScreen(cartItems: _cartItems),

      // // ✅ PASS USER DATA TO PROFILE
      // ProfileScreen(
      //   firstName: widget.firstName,
      //   lastName: widget.lastName,
      //   email: widget.email,
      //   address: widget.address, password: '',
      // ),

      // const AboutScreen(userName: '',),

      CheckoutScreen(
        cartItems: _cartItems,
        userName: widget.firstName,
        userLocation: widget.address,
      ),
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
              backgroundColor:
                  const Color.fromARGB(255, 229, 128, 162),
            )
          : null,

      body: _bottomScreens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor:
            const Color.fromARGB(255, 229, 128, 162),
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
