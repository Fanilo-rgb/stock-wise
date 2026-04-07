import 'package:go_router/go_router.dart';
import 'package:stock_wise_application/core/router/app_shell.dart';
import 'package:stock_wise_application/test/theme_test_screen.dart';

final goRouter = GoRouter(
  initialLocation: "/theme",
  routes: [
    ShellRoute(
      builder: (context, sate, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: "/dashboard",
          builder: (context, state) => const ThemeTestScreen(),
        ),
        GoRoute(
          path: "/inventory",
          builder: (context, state) => const ThemeTestScreen(),
        ),
        GoRoute(
          path: "/new-product",
          builder: (context, state) => const ThemeTestScreen(),
        ),
        GoRoute(
          path: "/shopping",
          builder: (context, state) => const ThemeTestScreen(),
        ),
        GoRoute(
          path: "/home",
          builder: (context, state) => const ThemeTestScreen(),
        ),
        GoRoute(
          path: "/theme",
          builder: (context, state) => const ThemeTestScreen(),
        ),
      ],
    ),
  ],
);
