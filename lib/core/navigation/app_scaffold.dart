import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/core/extensions/context_theme.dart';

import '../routing/app_routes.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _navItems = [
    AppRoutes.home,
    AppRoutes.history,
    AppRoutes.settings,
  ];

  int _calculateSelectedIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    final index = _navItems.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    final colors = context.colors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: colors.background,
      body: child,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.planTrip);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: colors.surface,
        child: Padding(
          padding: const EdgeInsets.only(right: 72),
          child: NavigationBarTheme(
            data: const NavigationBarThemeData(height: 60),
            child: NavigationBar(
              backgroundColor: colors.surface,
              indicatorColor: Colors.transparent,
              selectedIndex: selectedIndex,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,

              destinations: [
                NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                  selectedIcon: Icon(Icons.home, color: colors.primary),
                  label: l10n.home,
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.history_outlined,
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                  selectedIcon: Icon(Icons.history, color: colors.primary),
                  label: l10n.visited,
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person_outline,
                    color: colors.onSurface.withOpacity(0.6),
                  ),
                  selectedIcon: Icon(Icons.person, color: colors.primary),
                  label: l10n.profile,
                ),
              ],

              onDestinationSelected: (index) {
                context.go(_navItems[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
