class CartItem {
  final String name;
  final String image;
  final double price;
  int quantity;
  bool isBouquet;
  double deliveryCharge;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.isBouquet = false,
    this.deliveryCharge = 100, // Default delivery/pickup charge
  });

  double get totalPrice {
    double total = price * quantity;
    if (isBouquet) total += 1400; // bouquet charge
    total += deliveryCharge; // delivery/pickup charge
    return total;
  }
}
