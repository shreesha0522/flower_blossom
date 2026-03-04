import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;
  final Future<void> Function() onPaymentSuccess;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.onPaymentSuccess,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = 'esewa';
  bool isProcessing = false;

  void processPayment() async {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    setState(() => isProcessing = true);

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 16 : 12)),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 32 : 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: const Color.fromARGB(255, 229, 128, 162),
                strokeWidth: isTablet ? 4 : 3,
              ),
              SizedBox(height: isTablet ? 24 : 16),
              Text(
                "Processing Payment...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 22 : 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Simulate payment delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Close processing dialog
    Navigator.of(context).pop();

    if (!mounted) return;

    // Clear cart and save order
    await widget.onPaymentSuccess();
    await showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), content: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, color: Colors.green, size: 70), const SizedBox(height: 16), const Text("Payment Successful! 🌸", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center), const SizedBox(height: 20), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 229, 128, 162)), onPressed: () => Navigator.pop(context), child: const Text("Continue Shopping", style: TextStyle(color: Colors.white)))])));

    if (!mounted) return;

    // ✅ Navigate to dashboard removing all previous routes
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/dashboard',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(fontSize: isTablet ? 24 : 20)),
        backgroundColor: const Color.fromARGB(255, 229, 128, 162),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 20 : 16),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Total Amount: Rs ${widget.amount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 32 : 24),
            Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isTablet ? 16 : 12),
            RadioListTile(
              value: 'esewa',
              groupValue: selectedPayment,
              onChanged: (value) => setState(() => selectedPayment = value!),
              title: Text("eSewa",
                  style: TextStyle(fontSize: isTablet ? 18 : 16)),
              secondary: Image.asset('assets/images/esewa.png',
                  width: isTablet ? 90 : 70,
                  height: isTablet ? 90 : 70,
                  fit: BoxFit.contain),
              activeColor: const Color.fromARGB(255, 229, 128, 162),
            ),
            RadioListTile(
              value: 'khalti',
              groupValue: selectedPayment,
              onChanged: (value) => setState(() => selectedPayment = value!),
              title: Text("Khalti",
                  style: TextStyle(fontSize: isTablet ? 18 : 16)),
              secondary: Image.asset('assets/images/khalti.png',
                  width: isTablet ? 90 : 70,
                  height: isTablet ? 90 : 70,
                  fit: BoxFit.contain),
              activeColor: const Color.fromARGB(255, 229, 128, 162),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: isTablet ? 60 : 50,
              child: ElevatedButton(
                onPressed: isProcessing ? null : processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 229, 128, 162),
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isProcessing ? "Processing..." : "Pay Now",
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
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