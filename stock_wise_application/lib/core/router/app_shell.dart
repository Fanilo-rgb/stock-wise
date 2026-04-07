import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  // Ordre identique aux routes dans ShellRoute
  static const _tabs = [
    '/dashboard',
    '/inventory',
    '/new-product',
    '/shopping',
    "/home",
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    // Trouve l'index dont la route matche le debut de l'url courante
    for (int i = 0; i < _tabs.length; i++) {
      if (location.startsWith(_tabs[i])) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) {
          // go() reinitialise la pile
          context.go(_tabs[index]);
        },

        indicatorColor: Colors.transparent,
        destinations: [
          NavigationIcon(
            icon: Iconsax.element_4_copy,
            selectedIcon: Iconsax.element_4,
          ),
          NavigationIcon(icon: Iconsax.box_1_copy, selectedIcon: Iconsax.box_1),
          NavigationIcon(
            icon: Iconsax.add_square_copy,
            selectedIcon: Iconsax.add_square,
          ),
          NavigationIcon(icon: Iconsax.bag_copy, selectedIcon: Iconsax.bag),
          NavigationIcon(
            icon: Iconsax.home_2_copy,
            selectedIcon: Iconsax.home_2,
          ),
        ],
      ),
    );
  }
}

// effet glow des icon si selected
class NavigationIcon extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;

  const NavigationIcon({
    super.key,
    required this.icon,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Icon(icon),
      selectedIcon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.cyan.withValues(alpha: 0.15),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Icon(selectedIcon, color: Colors.cyan),
      ),
      label: '',
    );
  }
}
