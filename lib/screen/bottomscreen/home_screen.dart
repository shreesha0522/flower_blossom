import 'package:flower_blossom/models/cart_item.dart';
import 'package:flutter/material.dart';

import '../flower_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(CartItem) onAddToCart;

  const HomeScreen({super.key, required this.onAddToCart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

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

  final List<String> categoriesNames = ["Rose", "Pink Rose", "White Lily", "Daisy"];
  final List<String> bestSellersNames = ["Tulip", "Sunflower", "Pink Lily"];
  final List<String> newArrivalsNames = ["Baby's breath", "Myosotis"];

  final List<double> categoriesPrices = [80, 100, 80, 100];
  final List<double> bestSellersPrices = [80, 100, 80];
  final List<double> newArrivalsPrices = [100, 80];

  @override
  Widget build(BuildContext context) {
    // Helper widget for each horizontal section
    Widget horizontalSection(
        String title, List<String> images, List<String> names, List<double> prices) {
      final filteredData = <Map<String, dynamic>>[];

      for (int i = 0; i < images.length; i++) {
        final name = names[i].toLowerCase();
        if (name.contains(searchQuery.toLowerCase())) {
          filteredData.add({
            'image': images[i],
            'name': names[i],
            'price': prices[i],
          });
        }
      }

      if (filteredData.isEmpty) return const SizedBox();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final flower = filteredData[index]['image']!;
                final flowerName = filteredData[index]['name']!;
                final flowerPrice = filteredData[index]['price']!;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => FlowerDetailScreen(
      flowerName: flowerName,
      flowerImage: flower,
      description: "$flowerName is a beautiful flower.",
      price: flowerPrice,
      onAddToCart: widget.onAddToCart,
     ),
      // Pass the callback here
                          
                        ),
                      
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            flower,
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: Text(
                              flowerName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    horizontalSection(
                        "Shop Our Categories",
                        categoriesFlowers,
                        categoriesNames,
                        categoriesPrices),
                    horizontalSection(
                        "Best Sellers",
                        bestSellersFlowers,
                        bestSellersNames,
                        bestSellersPrices),
                    horizontalSection(
                        "New Arrivals",
                        newArrivalsFlowers,
                        newArrivalsNames,
                        newArrivalsPrices),
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
