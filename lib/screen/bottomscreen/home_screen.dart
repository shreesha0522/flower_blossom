import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  // Different flower lists for each section
  final List<String> categoriesFlowers = [
    'assets/images/home1.jpeg',
    'assets/images/home2.jpg',
    'assets/images/home3.jpg',
    'assets/images/home4.jpg',
  ];

  final List<String> bestSellersFlowers = [
    'assets/images/home5.jpg',
    'assets/images/home6.jpg',
    'assets/images/home7.jpg',
  ];

  final List<String> newArrivalsFlowers = [
    'assets/images/home9.jpg',
    'assets/images/home10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    // Helper widget for each horizontal section
    Widget horizontalSection(String title, List<String> images) {
      // Filter images based on search query
      final filteredImages = images
          .where((flower) =>
              flower.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200, // height of horizontal list
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredImages.length,
              itemBuilder: (context, index) {
                final flower = filteredImages[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(flower),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search flowers...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Vertical list of horizontal sections
              Expanded(
                child: ListView(
                  children: [
                    horizontalSection("Shop Our Categories", categoriesFlowers),
                    horizontalSection("Best Sellers", bestSellersFlowers),
                    horizontalSection("New Arrivals", newArrivalsFlowers),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}