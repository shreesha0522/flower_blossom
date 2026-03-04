import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flower_blossom/core/services/storage/user_session.dart';
import "package:flower_blossom/core/services/hive/hive_service.dart";
import "package:flower_blossom/features/cart/data/cart_hive_model.dart";
import 'package:flower_blossom/features/dashboard/presentation/pages/dashboard_screen.dart';

// Mock HiveService that doesn't use path_provider
class MockHiveService extends HiveService {
  @override
  List<CartItemHiveModel> getCartItems() => [];

  @override
  Future<void> saveCartItems(items) async {}

  @override
  Future<void> clearCart() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  Widget buildDashboard(SharedPreferences prefs) {
    return ProviderScope(
      overrides: [
        sharedPreferenceProvider.overrideWithValue(prefs),
        hiveServiceProvider.overrideWithValue(MockHiveService()),
      ],
      child: const MaterialApp(
        home: DashboardScreen(),
      ),
    );
  }

  group('DashboardScreen Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('should display dashboard screen', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('should display bottom navigation bar', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('should display all 4 navigation items', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Cart'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('should start on Home tab', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('should navigate to Cart when Cart tab is tapped', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.shopping_bag));
      await tester.pump();
      expect(find.text('Cart'), findsWidgets);
    });

    testWidgets('should navigate to About when About tab is tapped', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.info));
      await tester.pump();
      expect(find.text('About'), findsWidgets);
    });

    testWidgets('should display app bar on home screen', (tester) async {
      await tester.pumpWidget(buildDashboard(prefs));
      await tester.pump();
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
