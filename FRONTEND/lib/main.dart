import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistem_rekomendasi_sma/pages/splash_page.dart';
import 'package:sistem_rekomendasi_sma/provider/address_provider.dart';
import 'package:sistem_rekomendasi_sma/provider/post_calculate_provider.dart';
import 'package:sistem_rekomendasi_sma/style/app_theme.dart';

import 'service/api_service.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider(
      create: (context) => ApiService(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddressProvider(
        context.read<ApiService>(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => PostCalculateProvider(
        context.read<ApiService>(),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Rekomendasi SMA',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
