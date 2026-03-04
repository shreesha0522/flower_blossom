import 'package:flower_blossom/core/constant/hive_table_constant.dart';
import 'package:flower_blossom/features/auth/data/models/auth_hive_model.dart';
import 'package:flower_blossom/features/cart/data/cart_hive_model.dart';
import 'package:flower_blossom/features/order/data/order_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/${HiveTableConstant.dbName}";
    Hive.init(path);
    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)) {
      Hive.registerAdapter(AuthHiveModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTableConstant.cartTypeId)) {
      Hive.registerAdapter(CartItemHiveModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTableConstant.orderTypeId)) {
      Hive.registerAdapter(OrderHiveModelAdapter());
    }
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
    await Hive.openBox<CartItemHiveModel>(HiveTableConstant.cartTable);
    await Hive.openBox<OrderHiveModel>(HiveTableConstant.orderTable);
  }

  Future<void> closeBoxes() async {
    await Hive.close();
  }

  // =================== Auth CRUD ===================
  Box<AuthHiveModel> get _authBox =>
      Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  Future<AuthHiveModel> registerUser(AuthHiveModel model) async {
    await _authBox.put(model.authId, model);
    return model;
  }

  Future<AuthHiveModel?> loginUser(String email, String password) async {
    final user = _authBox.values.where(
      (user) => user.email == email && user.password == password,
    );
    if (user.isNotEmpty) return user.first;
    return null;
  }

  Future<AuthHiveModel?> getCurrentUser(String authId) async {
    return _authBox.get(authId);
  }

  Future<bool> isEmailExists(String email) async {
    final users = _authBox.values.where((user) => user.email == email);
    return users.isNotEmpty;
  }

  Future<void> logoutUser() async {}

  // =================== Cart CRUD ===================
  Box<CartItemHiveModel> get _cartBox =>
      Hive.box<CartItemHiveModel>(HiveTableConstant.cartTable);

  Future<void> saveCartItems(List<CartItemHiveModel> items) async {
    await _cartBox.clear();
    for (int i = 0; i < items.length; i++) {
      await _cartBox.put(i, items[i]);
    }
  }

  List<CartItemHiveModel> getCartItems() {
    return _cartBox.values.toList();
  }

  Future<void> clearCart() async {
    await _cartBox.clear();
  }
  // =================== Order CRUD ===================
  Box<OrderHiveModel> get _orderBox =>
      Hive.box<OrderHiveModel>(HiveTableConstant.orderTable);

  Future<void> saveOrder(OrderHiveModel order) async {
    await _orderBox.put(order.orderId, order);
  }

  List<OrderHiveModel> getOrdersByUser(String userId) {
    return _orderBox.values
        .where((order) => order.userId == userId)
        .toList();
  }

  List<OrderHiveModel> getAllOrders() {
    return _orderBox.values.toList();
  }
}