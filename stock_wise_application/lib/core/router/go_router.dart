import 'package:go_router/go_router.dart';
import 'package:stock_wise_application/core/router/app_shell.dart';
import 'package:stock_wise_application/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:stock_wise_application/features/home/presentation/screens/home_screen.dart';
import 'package:stock_wise_application/features/product/presentation/screens/add_product_screen.dart';
import 'package:stock_wise_application/features/product/presentation/screens/inventory_screen.dart';
import 'package:stock_wise_application/features/product/presentation/screens/product_details_screen.dart';
import 'package:stock_wise_application/features/shopping/presentation/screens/shopping_screen.dart';
import 'package:stock_wise_application/test/theme_test_screen.dart';

final goRouter = GoRouter(
  initialLocation: "/dashboard",
  routes: [
    ShellRoute(
      builder: (context, sate, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: "/dashboard",
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: "/inventory",
          builder: (context, state) => const InventoryScreen(),
          routes: [
            GoRoute(
              path: ":id",
              builder: (context, state) {
                final productId = state.pathParameters["id"]!;
                return ProductDetailsScreen(productId: productId);
              },
            ),
          ],
        ),
        GoRoute(
          path: "/new-product",
          builder: (context, state) => const AddProductScreen(),
        ),
        GoRoute(
          path: "/shopping",
          builder: (context, state) => const ShoppingScreen(),
        ),
        GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: "/theme",
          builder: (context, state) => const ThemeTestScreen(),
        ),
      ],
    ),
  ],
);
