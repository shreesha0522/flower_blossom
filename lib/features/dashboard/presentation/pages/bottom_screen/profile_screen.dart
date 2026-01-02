import 'package:flutter/material.dart';
import 'package:flower_blossom/core/utils/user_storage.dart';

class ProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String password;

  const ProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.password,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController passwordController;

  bool isEditing = false;
  final String profileImagePath = 'assets/images/girl.jpg';

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    emailController = TextEditingController(text: widget.email);
    addressController = TextEditingController(text: widget.address);
    passwordController = TextEditingController(text: widget.password);
  }

  void showCenterMessage(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
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

  bool validateProfile() {
    if (firstNameController.text.trim().isEmpty) {
      showCenterMessage("First name cannot be empty");
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      showCenterMessage("Last name cannot be empty");
      return false;
    }
    if (emailController.text.trim().isEmpty) {
      showCenterMessage("Email cannot be empty");
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(emailController.text.trim())) {
      showCenterMessage("Enter a valid email");
      return false;
    }
    if (passwordController.text.trim().isEmpty) {
      showCenterMessage("Password cannot be empty");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 229, 128, 162),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profileImagePath),
              onBackgroundImageError: (_, __) {
                // Fallback if asset fails
              },
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: firstNameController,
              enabled: isEditing,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: lastNameController,
              enabled: isEditing,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              enabled: isEditing,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: addressController,
              enabled: isEditing,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: passwordController,
              enabled: isEditing,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (isEditing) {
                    if (validateProfile()) {
                      // Update UserStorage
                      UserStorage.register(
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        email: emailController.text.trim(),
                        address: addressController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      showCenterMessage("Profile updated successfully");

                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/dashboard',
                          arguments: {
                            'firstName': firstNameController.text.trim(),
                            'lastName': lastNameController.text.trim(),
                            'email': emailController.text.trim(),
                            'address': addressController.text.trim(),
                          },
                        );
                      });
                    }
                  }

                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEditing ? "Save" : "Edit",
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
