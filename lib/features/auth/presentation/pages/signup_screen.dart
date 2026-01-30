import 'package:flower_blossom/app/common/my_snack_bar.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';
import 'package:flower_blossom/features/auth/presentation/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_screen.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  // ✅ UPDATED: Controllers for all required fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      ref.read(authViewModelProvider.notifier).register(
        fullName: fullNameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        showMySnackBar(
          context: context,
          message: next.errorMessage ?? "Registration failed",
        );
      } else if (next.status == AuthStatus.registered) {
        showMySnackBar(context: context, message: "Registration successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCE4EC),
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: isTablet ? 24 : 20),
        ),
        elevation: 0,
        iconTheme: IconThemeData(size: isTablet ? 28 : 24),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(isTablet ? 48 : 24),
            margin: EdgeInsets.symmetric(horizontal: isTablet ? 48 : 24),
            constraints: BoxConstraints(
              maxWidth: isTablet ? 600 : double.infinity,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isTablet ? 24 : 16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8)
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/Picture1.png',
                    height: isTablet ? 150 : 100,
                  ),
                  SizedBox(height: isTablet ? 40 : 32),

                  // ✅ Full Name Field
                  TextFormField(
                    controller: fullNameController,
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                      prefixIcon: Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 229, 128, 162),
                        size: isTablet ? 28 : 24,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20 : 16),

                  // ✅ Username Field
                  TextFormField(
                    controller: usernameController,
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: const Color.fromARGB(255, 229, 128, 162),
                        size: isTablet ? 28 : 24,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20 : 16),

                  // ✅ Email Field
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                      prefixIcon: Icon(
                        Icons.email,
                        color: const Color.fromARGB(255, 229, 128, 162),
                        size: isTablet ? 28 : 24,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20 : 16),

                  // ✅ Password Field
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: const Color.fromARGB(255, 229, 128, 162),
                        size: isTablet ? 28 : 24,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 20 : 16),

                  // ✅ Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: const Color.fromARGB(255, 229, 128, 162),
                        size: isTablet ? 28 : 24,
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 32 : 24),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: _handleSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                      foregroundColor: Colors.black,
                      minimumSize: Size(
                        double.infinity,
                        isTablet ? 60 : 48,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      textStyle: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 16),

                  // Login Redirect
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 11, 11, 11),
                        fontSize: isTablet ? 16 : 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}