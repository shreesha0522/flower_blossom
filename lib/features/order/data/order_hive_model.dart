import 'package:hive/hive.dart';
import 'package:flower_blossom/core/constant/hive_table_constant.dart';
part 'order_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.orderTypeId)
class OrderHiveModel extends HiveObject {
  @HiveField(0)
  final String orderId;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final List<String> itemNames;

  @HiveField(3)
  final List<double> itemPrices;

  @HiveField(4)
  final List<int> itemQuantities;

  @HiveField(5)
  final double totalAmount;

  @HiveField(6)
  final String orderDate;

  @HiveField(7)
  final String paymentMethod;

  OrderHiveModel({
    required this.orderId,
    required this.userId,
    required this.itemNames,
    required this.itemPrices,
    required this.itemQuantities,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentMethod,
  });
}
