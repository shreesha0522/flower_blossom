import 'package:flower_blossom/models/cart_item.dart';
import 'package:flutter/material.dart';

class FlowerDetailScreen extends StatefulWidget {
  final String flowerName;
  final String flowerImage;
  final String description;
  final double price;
  final Function(CartItem) onAddToCart;

  const FlowerDetailScreen({
    super.key,
    required this.flowerName,
    required this.flowerImage,
    required this.description,
    required this.price,
    required this.onAddToCart,
  });

  @override
  State<FlowerDetailScreen> createState() => _FlowerDetailScreenState();
}

class _FlowerDetailScreenState extends State<FlowerDetailScreen> {
  int quantity = 1;
  bool isFavorite = false;
  bool isBouquet = false;

  void showAddedToCartPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Color.fromARGB(255, 229, 128, 162), size: 60),
                const SizedBox(height: 12),
                const Text("Added to Cart", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(widget.flowerName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 229, 128, 162),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double get totalPrice => widget.price * quantity + (isBouquet ? 1400 : 0);

  void addToCart() {
    widget.onAddToCart(
      CartItem(
        name: widget.flowerName,
        image: widget.flowerImage,
        price: widget.price,
        quantity: quantity,
        isBouquet: isBouquet,
      ),
    );
    showAddedToCartPopup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(height: 320, width: double.infinity, child: Image.asset(widget.flowerImage, fit: BoxFit.cover)),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.flowerName, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Rs ${widget.price.toStringAsFixed(0)} per flower",
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 229, 128, 162), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Total: Rs ${totalPrice.toStringAsFixed(0)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  const SizedBox(height: 16),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.description, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quantity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: quantity > 1 ? () => setState(() => quantity--) : null),
                          Text(quantity.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => setState(() => quantity++)),
                        ],
                      ),
                    ],
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Make it a bouquet (+ Rs 1400)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    value: isBouquet,
                    activeThumbColor: const Color.fromARGB(255, 229, 128, 162),
                    onChanged: (value) => setState(() => isBouquet = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          // ignore: deprecated_member_use
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 60,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: const Color.fromARGB(255, 229, 128, 162)),
                onPressed: () => setState(() => isFavorite = !isFavorite),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  label: const Text("Add to Cart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 229, 128, 162), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: addToCart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
