import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _navItems = ['/home', '/history', '/profile'];

  int _calculateSelectedIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    final index = _navItems.indexWhere((path) => location.startsWith(path));
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: child,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/plan-trip');
        },
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Visited'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onDestinationSelected: (index) {
          context.go(_navItems[index]);
        },
      ),
    );
  }
}
