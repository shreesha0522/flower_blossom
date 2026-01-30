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
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    setState(() {
      isProcessing = true;
    });

    // Show processing payment dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isTablet ? 16 : 12)),
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

    await Future.delayed(const Duration(seconds: 2)); // Simulate payment delay

    if (!mounted) return;
    
    Navigator.pop(context); // Close processing dialog
    
    if (!mounted) return;
    
    // Show success message in PINK
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment Successful! Rs ${widget.amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTablet ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 229, 128, 162), // PINK COLOR
        duration: const Duration(seconds: 2),
      ),
    );

    // Wait a moment for user to see the success message
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (!mounted) return;

    // Call the success callback which navigates to dashboard
    widget.onPaymentSuccess();

    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(fontSize: isTablet ? 24 : 20),
        ),
        backgroundColor: const Color.fromARGB(255, 229, 128, 162),
        centerTitle: true,
        iconTheme: IconThemeData(size: isTablet ? 28 : 24),
      ),
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Amount: Rs ${widget.amount.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: isTablet ? 24 : 20,
                fontWeight: FontWeight.bold,
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
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              title: Text(
                "eSewa",
                style: TextStyle(fontSize: isTablet ? 18 : 16),
              ),
              secondary: Image.asset(
                'assets/images/esewa.png',
                width: isTablet ? 90 : 70,
                height: isTablet ? 90 : 70,
                fit: BoxFit.contain,
              ),
              activeColor: const Color.fromARGB(255, 229, 128, 162),
            ),
            
            RadioListTile(
              value: 'khalti',
              groupValue: selectedPayment,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
              title: Text(
                "Khalti",
                style: TextStyle(fontSize: isTablet ? 18 : 16),
              ),
              secondary: Image.asset(
                'assets/images/khalti.png',
                width: isTablet ? 90 : 70,
                height: isTablet ? 90 : 70,
                fit: BoxFit.contain,
              ),
              activeColor: const Color.fromARGB(255, 229, 128, 162),
            ),
            
            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isProcessing ? null : processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 20 : 16,
                  ),
                  disabledBackgroundColor: Colors.grey,
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