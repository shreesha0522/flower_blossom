import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double amount; // Total amount to pay
  final VoidCallback onPaymentSuccess; // Callback after payment is done

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = 'esewa'; // Default payment method
  bool isProcessing = false; // Track payment processing

  void processPayment() async {
    setState(() {
      isProcessing = true;
    });

    // Show processing payment dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "Processing Payment...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 2)); // Simulate payment delay

    // ignore: use_build_context_synchronously
    Navigator.pop(context); // Close processing dialog

    // Show Payment Successful dialog
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Payment Successful"),
        content: Text(
          "Your payment of Rs ${widget.amount.toStringAsFixed(0)} using ${selectedPayment.toUpperCase()} was successful!",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close success dialog
              widget.onPaymentSuccess(); // Optional callback

              // Navigate to dashboard screen
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );

    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: const Color.fromARGB(255, 229, 128, 162),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Amount: Rs ${widget.amount.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              "Choose Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            RadioListTile(
              value: 'esewa',
              // ignore: deprecated_member_use
              groupValue: selectedPayment,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              title: const Text("eSewa"),
              secondary: Image.asset(
                'assets/images/esewa.png',
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            RadioListTile(
              value: 'khalti',
              // ignore: deprecated_member_use
              groupValue: selectedPayment,
              // ignore: deprecated_member_use
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              title: const Text("Khalti"),
              secondary: Image.asset(
                'assets/images/khalti.png',
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isProcessing ? null : processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isProcessing ? "Processing..." : "Pay Now",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
