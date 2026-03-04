import 'package:flutter_test/flutter_test.dart';
import 'package:flower_blossom/core/constant/hive_table_constant.dart';

void main() {
  group('HiveTableConstant Tests', () {
    test('should have correct db name', () {
      expect(HiveTableConstant.dbName, 'flower_blossom_db');
    });
    test('should have correct auth type id', () {
      expect(HiveTableConstant.authTypeId, 0);
    });
    test('should have correct cart type id', () {
      expect(HiveTableConstant.cartTypeId, 1);
    });
    test('should have correct auth table name', () {
      expect(HiveTableConstant.authTable, 'auth_table');
    });
    test('should have correct cart table name', () {
      expect(HiveTableConstant.cartTable, 'cart_table');
    });
  });
}
