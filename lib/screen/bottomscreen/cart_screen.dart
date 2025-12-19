// import 'package:flower_blossom/screen/checkout_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flower_blossom/models/cart_item.dart';

// class CartScreen extends StatefulWidget {
//   final List<CartItem> cartItems;

//   const CartScreen({super.key, required this.cartItems});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   double get grandTotal =>
//       widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);

//   void showCenterMessage(String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Center(
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.pink.shade200,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               message,
//               style: const TextStyle(
//                   color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
//       overlayEntry.remove();
//     });
//   }

//   Widget cartItemTile(CartItem item, int index) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.asset(
//                 item.image,
//                 width: 70,
//                 height: 70,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item.name,
//                     style: const TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text("Rs ${item.price.toStringAsFixed(0)} per flower"),
//                   if (item.isBouquet)
//                     const Text(
//                       "+ Bouquet Rs 1400",
//                       style: TextStyle(
//                           color: Colors.black87, fontWeight: FontWeight.bold),
//                     ),
//                   const SizedBox(height: 4),
//                   Text("Total: Rs ${item.totalPrice.toStringAsFixed(0)}",
//                       style: const TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.add_circle_outline),
//                   onPressed: () {
//                     setState(() {
//                       item.quantity++;
//                     });
//                   },
//                 ),
//                 Text(item.quantity.toString(),
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//                 IconButton(
//                   icon: const Icon(Icons.remove_circle_outline),
//                   onPressed: item.quantity > 1
//                       ? () {
//                           setState(() {
//                             item.quantity--;
//                           });
//                         }
//                       : null,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       widget.cartItems.removeAt(index);
//                     });
//                     showCenterMessage("Deleted successfully");
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCE4EC),
//       // ✅ Remove AppBar entirely
//       body: widget.cartItems.isEmpty
//           ? const Center(
//               child: Text(
//                 "Your cart is empty",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.only(bottom: 16),
//               itemCount: widget.cartItems.length,
//               itemBuilder: (context, index) =>
//                   cartItemTile(widget.cartItems[index], index),
//             ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Grand Total: Rs ${grandTotal.toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87),
//             ),
//             ElevatedButton(
//               onPressed: widget.cartItems.isEmpty
//                   ? null
//                   : () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => CheckoutScreen(
//                             cartItems: widget.cartItems,
//                             userName: "YourUserName", // Replace with actual user name
//                             userLocation: "YourUserLocation", // Replace with actual user location
//                           ),
//                         ),
//                       );
//                     },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 229, 128, 162),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//               child: const Text(
//                 "Checkout",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
