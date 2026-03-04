import 'dart:async';
import 'dart:math';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';
import 'package:flower_blossom/core/widgets/flower_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeScreen extends StatefulWidget {
  final Function(CartItem) onAddToCart;
  const HomeScreen({super.key, required this.onAddToCart});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';

  List<String> categoriesFlowers = [
    'assets/images/home1.jpeg',
    'assets/images/home2.jpg',
    'assets/images/home3.jpg',
    'assets/images/home4.jpg',
  ];
  List<String> bestSellersFlowers = [
    'assets/images/home5.jpg',
    'assets/images/home6.jpg',
    'assets/images/home7.jpg',
  ];
  List<String> newArrivalsFlowers = [
    'assets/images/home9.jpg',
    'assets/images/home10.jpg',
  ];

  List<String> categoriesNames = ["Rose", "Pink Rose", "White Lily", "Daisy"];
  List<String> bestSellersNames = ["Tulip", "Sunflower", "Pink Lily"];
  List<String> newArrivalsNames = ["Baby's breath", "Myosotis"];

  List<double> categoriesPrices = [80, 100, 80, 100];
  List<double> bestSellersPrices = [80, 100, 80];
  List<double> newArrivalsPrices = [100, 80];

  // Accelerometer / shake
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  double _lastX = 0, _lastY = 0, _lastZ = 0;
  DateTime _lastShakeTime = DateTime.now();
  bool _showShakeBanner = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _startAccelerometer();
  }

  void _startAccelerometer() {
    try {
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      final double deltaX = (event.x - _lastX).abs();
      final double deltaY = (event.y - _lastY).abs();
      final double deltaZ = (event.z - _lastZ).abs();

      _lastX = event.x;
      _lastY = event.y;
      _lastZ = event.z;

      final double shakeStrength = deltaX + deltaY + deltaZ;
      final now = DateTime.now();

      // Trigger shuffle if shake is strong enough and 1 second has passed
      if (shakeStrength > 12 &&
          now.difference(_lastShakeTime).inMilliseconds > 1000) {
        _lastShakeTime = now;
        _shuffleFlowers();
      }
    });
    } catch (e) {
      debugPrint("Accelerometer not available: $e");
    }
  }

  void _shuffleFlowers() {
    final random = Random();
    setState(() {
      // Shuffle all sections together
      final combined = List.generate(
        categoriesFlowers.length,
        (i) => {
          'image': categoriesFlowers[i],
          'name': categoriesNames[i],
          'price': categoriesPrices[i],
        },
      );
      combined.shuffle(random);
      categoriesFlowers = combined.map((e) => e['image'] as String).toList();
      categoriesNames = combined.map((e) => e['name'] as String).toList();
      categoriesPrices = combined.map((e) => e['price'] as double).toList();

      final bestCombined = List.generate(
        bestSellersFlowers.length,
        (i) => {
          'image': bestSellersFlowers[i],
          'name': bestSellersNames[i],
          'price': bestSellersPrices[i],
        },
      );
      bestCombined.shuffle(random);
      bestSellersFlowers =
          bestCombined.map((e) => e['image'] as String).toList();
      bestSellersNames =
          bestCombined.map((e) => e['name'] as String).toList();
      bestSellersPrices =
          bestCombined.map((e) => e['price'] as double).toList();

      final newCombined = List.generate(
        newArrivalsFlowers.length,
        (i) => {
          'image': newArrivalsFlowers[i],
          'name': newArrivalsNames[i],
          'price': newArrivalsPrices[i],
        },
      );
      newCombined.shuffle(random);
      newArrivalsFlowers =
          newCombined.map((e) => e['image'] as String).toList();
      newArrivalsNames =
          newCombined.map((e) => e['name'] as String).toList();
      newArrivalsPrices =
          newCombined.map((e) => e['price'] as double).toList();

      _showShakeBanner = true;
    });

    // Hide banner after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showShakeBanner = false);
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget horizontalSection(String title, List<String> images,
      List<String> names, List<double> prices, bool isTablet) {
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
          padding: EdgeInsets.symmetric(vertical: isTablet ? 12.0 : 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 28 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: isTablet ? 280 : 200,
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
                    ),
                  );
                },
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500 + (index * 100)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Container(
                    width: isTablet ? 220 : 150,
                    margin: EdgeInsets.only(right: isTablet ? 16 : 12),
                    child: Stack(
                      children: [
                        Hero(
                          tag: flowerName,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(isTablet ? 20 : 16),
                            child: Image.asset(
                              flower,
                              width: isTablet ? 220 : 150,
                              height: isTablet ? 280 : 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: isTablet ? 10 : 6,
                              horizontal: isTablet ? 12 : 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(isTablet ? 20 : 16),
                                bottomRight:
                                    Radius.circular(isTablet ? 20 : 16),
                              ),
                            ),
                            child: Text(
                              flowerName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 18 : 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            children: [
              // 🌸 Shake banner
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showShakeBanner
                    ? Container(
                        key: const ValueKey('banner'),
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 229, 128, 162),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🌸', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 8),
                            Text(
                              'Flowers shuffled!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(key: ValueKey('empty')),
              ),

              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() => searchQuery = value);
                },
                style: TextStyle(fontSize: isTablet ? 18 : 14),
                decoration: InputDecoration(
                  hintText: 'Search flowers...',
                  hintStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                  prefixIcon: Icon(Icons.search, size: isTablet ? 28 : 24),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 20 : 16,
                    vertical: isTablet ? 18 : 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(isTablet ? 16 : 12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: isTablet ? 24 : 16),

              Expanded(
                child: ListView(
                  children: [
                    horizontalSection(
                        "Shop Our Categories",
                        categoriesFlowers,
                        categoriesNames,
                        categoriesPrices,
                        isTablet),
                    horizontalSection("Best Sellers", bestSellersFlowers,
                        bestSellersNames, bestSellersPrices, isTablet),
                    horizontalSection("New Arrivals", newArrivalsFlowers,
                        newArrivalsNames, newArrivalsPrices, isTablet),
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