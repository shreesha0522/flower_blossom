import 'package:flower_blossom/features/cart/presentation/checkout_screen.dart';
import 'package:flower_blossom/features/cart/presentation/view_model/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  void showCenterMessage(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cartViewModelProvider);
    final viewModel = ref.read(cartViewModelProvider.notifier);
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: state.cartItems.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: isTablet ? 24 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: isTablet ? 24 : 16),
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final item = state.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24 : 12,
                    vertical: isTablet ? 12 : 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(isTablet ? 12 : 8),
                          child: Image.asset(
                            item.image,
                            width: isTablet ? 100 : 70,
                            height: isTablet ? 100 : 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: isTablet ? 16 : 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: isTablet ? 26 : 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: isTablet ? 6 : 4),
                              Text(
                                "Rs ${item.price.toStringAsFixed(0)} per flower",
                                style:
                                    TextStyle(fontSize: isTablet ? 16 : 14),
                              ),
                              if (item.isBouquet)
                                Text(
                                  "+ Bouquet Rs 1400",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                              SizedBox(height: isTablet ? 6 : 4),
                              Text(
                                "Total: Rs ${item.totalPrice.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 18 : 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  size: isTablet ? 32 : 24),
                              onPressed: () =>
                                  viewModel.increaseQuantity(index),
                            ),
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 18 : 16,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  size: isTablet ? 32 : 24),
                              onPressed: item.quantity > 1
                                  ? () => viewModel.decreaseQuantity(index)
                                  : null,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red,
                                  size: isTablet ? 32 : 24),
                              onPressed: () async {
                                await viewModel.removeItem(index);
                                if (context.mounted) {
                                  showCenterMessage(
                                      context, "Deleted successfully");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 16,
          vertical: isTablet ? 16 : 12,
        ),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Grand Total: Rs ${state.grandTotal.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: isTablet ? 22 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: isTablet ? 16 : 8),
            ElevatedButton(
              onPressed: state.cartItems.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            cartItems: state.cartItems,
                            userName: "Flower Blossom User",
                            userLocation: "Kathmandu, Nepal",
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 24,
                  vertical: isTablet ? 16 : 12,
                ),
              ),
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: isTablet ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
