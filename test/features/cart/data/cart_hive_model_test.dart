import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/cart/data/cart_hive_model.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

void main() {
  group('CartItemHiveModel Tests', () {
    test('should create model with required fields', () {
      final model = CartItemHiveModel(
        name: 'Rose',
        image: 'assets/images/rose.jpg',
        price: 500,
      );
      expect(model.name, 'Rose');
      expect(model.price, 500);
      expect(model.quantity, 1);
      expect(model.isBouquet, false);
      expect(model.deliveryCharge, 100);
    });

    test('should convert to CartItem correctly', () {
      final model = CartItemHiveModel(
        name: 'Rose',
        image: 'assets/images/rose.jpg',
        price: 500,
        quantity: 2,
      );
      final cartItem = model.toCartItem();
      expect(cartItem.name, 'Rose');
      expect(cartItem.price, 500);
      expect(cartItem.quantity, 2);
    });

    test('should create from CartItem correctly', () {
      final cartItem = CartItem(
        name: 'Tulip',
        image: 'assets/images/tulip.jpg',
        price: 300,
        quantity: 3,
      );
      final model = CartItemHiveModel.fromCartItem(cartItem);
      expect(model.name, 'Tulip');
      expect(model.price, 300);
      expect(model.quantity, 3);
    });
  });
}
