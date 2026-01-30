import 'package:flower_blossom/app/app_routes.dart';
import 'package:flower_blossom/core/utils/snack_bar_utils.dart';
import 'package:flower_blossom/features/auth/presentation/state/auth_state.dart';
import 'package:flower_blossom/features/auth/presentation/view_model/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flower_blossom/features/auth/presentation/pages/signup_screen.dart';
import 'package:flower_blossom/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flower_blossom/core/utils/user_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authViewModelProvider.notifier).login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
    }
  }
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ Show message in the center
  void showCenterMessage(String message, {Color color = const Color.fromARGB(255, 229, 128, 162)}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    
    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        AppRoutes.pushReplacement(context, DashboardScreen());
      } else if (next.status == AuthStatus.error &&
          next.errorMessage != null) {
        SnackbarUtils.showError(context, next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
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
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 🌸 Logo
                  Image.asset(
                    'assets/images/Picture1.png',
                    height: isTablet ? 150 : 100,
                  ),
                  SizedBox(height: isTablet ? 32 : 24),

                  // Email
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
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                        showCenterMessage('Enter a valid email', color: Colors.red.shade300);
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 24 : 16),

                  // Password
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
                      if (value == null || value.isEmpty) return 'Please enter your password';
                      if (value.length < 8) return 'Password must be at least 8 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: isTablet ? 32 : 24),

                  // Login button
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                      foregroundColor: Colors.black,
                      minimumSize: Size(
                        double.infinity,
                        isTablet ? 60 : 48,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 16),

                  // Sign up redirect
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign up",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 26, 26, 26),
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