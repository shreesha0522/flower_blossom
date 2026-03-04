import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/features/order/data/order_hive_model.dart';

void main() {
  group('OrderHiveModel Tests', () {
    test('should create model with required fields', () {
      final model = OrderHiveModel(
        orderId: 'order-001',
        userId: 'user-001',
        itemNames: ['Rose', 'Tulip'],
        itemPrices: [500.0, 300.0],
        itemQuantities: [2, 1],
        totalAmount: 1300.0,
        orderDate: '2025-01-01',
        paymentMethod: 'eSewa',
      );
      expect(model.orderId, 'order-001');
      expect(model.userId, 'user-001');
      expect(model.itemNames, ['Rose', 'Tulip']);
      expect(model.totalAmount, 1300.0);
      expect(model.paymentMethod, 'eSewa');
    });

    test('should store correct item quantities', () {
      final model = OrderHiveModel(
        orderId: 'order-002',
        userId: 'user-002',
        itemNames: ['Daisy'],
        itemPrices: [200.0],
        itemQuantities: [3],
        totalAmount: 600.0,
        orderDate: '2025-02-01',
        paymentMethod: 'Khalti',
      );
      expect(model.itemQuantities, [3]);
      expect(model.itemPrices, [200.0]);
    });
  });
}
