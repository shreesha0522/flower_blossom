import 'package:hive/hive.dart';
import 'package:flower_blossom/core/constant/hive_table_constant.dart';
import 'package:flower_blossom/features/cart/presentation/cart_item.dart';

part 'cart_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.cartTypeId)
class CartItemHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final double price;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  bool isBouquet;

  @HiveField(5)
  double deliveryCharge;

  CartItemHiveModel({
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.isBouquet = false,
    this.deliveryCharge = 100,
  });

  CartItem toCartItem() => CartItem(
        name: name,
        image: image,
        price: price,
        quantity: quantity,
        isBouquet: isBouquet,
        deliveryCharge: deliveryCharge,
      );

  factory CartItemHiveModel.fromCartItem(CartItem item) => CartItemHiveModel(
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: item.quantity,
        isBouquet: item.isBouquet,
        deliveryCharge: item.deliveryCharge,
      );
}
