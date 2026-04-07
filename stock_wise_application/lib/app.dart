import 'package:flutter/material.dart';
import 'package:stock_wise_application/core/router/go_router.dart';
import 'package:stock_wise_application/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StockWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: goRouter,
    );
  }
}
