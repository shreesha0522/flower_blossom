import 'package:flutter/material.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';
import 'payment_screen.dart'; // Import your payment screen

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final String userName; // From login/signup
  final String userLocation; // From login/signup

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.userName,
    required this.userLocation,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String phone = '';
  String selectedDelivery = '1-3 Days';
  final double deliveryCharge = 100;

  double get itemsTotal =>
      widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get grandTotal => itemsTotal + deliveryCharge;

  void showOrderSuccess() {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.black, size: 60),
                const SizedBox(height: 12),
                const Text(
                  "Order Placed Successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((route) => route.isFirst); // back to home
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cartItemTile(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            "Rs ${item.price.toStringAsFixed(0)} x ${item.quantity} = Rs ${item.totalPrice.toStringAsFixed(0)}"),
      ),
    );
  }

  void proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentScreen(
            amount: grandTotal,
            onPaymentSuccess: () {
              showOrderSuccess();
              Navigator.pop(context); // Close payment screen
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 128, 162),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.pink.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.userLocation,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Your Cart",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...widget.cartItems.map((item) => cartItemTile(item)),
            const Divider(height: 32, thickness: 2),
            // Delivery Options
            const Text(
              "Delivery Options",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: selectedDelivery,
              items: const [
                DropdownMenuItem(
                    value: '1-3 Days', child: Text("1-3 Days (Delivery/Pickup Rs 100)")),
                DropdownMenuItem(
                    value: 'Same Day', child: Text("Same Day Delivery (Rs 100)")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDelivery = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Delivery Charge: Rs ${deliveryCharge.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Grand Total: Rs ${grandTotal.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 24),
            // Phone number
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Phone Number", border: OutlineInputBorder()),
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.isEmpty ? "Please enter your phone number" : null,
                    onSaved: (value) => phone = value!,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: proceedToPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 229, 128, 162),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Proceed to Pay",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
