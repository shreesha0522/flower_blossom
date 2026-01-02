import 'package:flutter/material.dart';

ThemeData getFlowerBlossomTheme() {
  return ThemeData(
    // General text styling
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 18, color: Colors.green[900], fontWeight: FontWeight.w500),
      displayMedium: TextStyle(fontSize: 22, color: Colors.brown[700], fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 26, color: Colors.pink[600], fontWeight: FontWeight.w700),
    ),

    // Background color
    scaffoldBackgroundColor: Color(0xFFFDF6F0),

    // Font family (choose something floral/elegant)
    fontFamily: "Bricolage",

    // Bottom Navigation Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFEF9A9A), // soft pink
      unselectedItemColor: Colors.grey[600],
      selectedIconTheme: IconThemeData(size: 28),
      selectedLabelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontSize: 14),
      showUnselectedLabels: true,
    ),

    // Elevated Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF81C784), // pastel green
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF81C784)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFEF9A9A), width: 2),
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
    
    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF81C784),
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),
  );
}
