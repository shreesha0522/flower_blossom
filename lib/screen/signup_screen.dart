import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: Text("SignUp Screen"),
      ), // soft pink background
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🌸 Logo
                Image.asset(
                  'assets/images/Picture1.png',
                  height: 100,
                ),
                const SizedBox(height: 16),

                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA64CA6),
                  ),
                ),
                const SizedBox(height: 24),

                // First Name
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Last Name
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    prefixIcon: Icon(Icons.person_outline, color: Colors.pinkAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Address
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.home, color: Colors.pinkAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.pinkAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    final firstName = firstNameController.text;
                    final lastName = lastNameController.text;
                    final address = addressController.text;
                    final password = passwordController.text;

                    
                    print("Sign Up pressed: $firstName $lastName / $address / $password");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // back to login
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Color(0xFFA64CA6)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// shreesha
