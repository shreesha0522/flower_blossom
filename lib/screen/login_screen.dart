import 'package:flutter/material.dart';
import 'package:flower_blossom/screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC), // soft pink background
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
                // 🌸 Logo only
                Image.asset(
                  'assets/images/Picture1.png',
                  height: 100,
                ),
                const SizedBox(height: 24),

                // Email field
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.pinkAccent),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field
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

                // Login button
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text;
                    final password = passwordController.text;
                    // ignore: avoid_print
                    print("Login pressed: $email / $password");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Sign up link (fixed)
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()) );
                  },
                  child: const Text(
                    "Don’t have an account? Sign up",
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

