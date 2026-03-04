import 'package:flower_blossom/app/theme/theme_provider.dart';
import 'package:flower_blossom/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flower_blossom/app/theme/theme_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getFlowerBlossomTheme(),
      darkTheme: getFlowerBlossomDarkTheme(),
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
