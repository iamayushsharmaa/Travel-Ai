import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidgetTree extends StatelessWidget {
  final Widget child;

  const WidgetTree({super.key, required this.child});

  static const _navItems = ['/trip', '/history', '/addtrip'];

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
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 15,
            color: Colors.blueAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        animationDuration: Duration(milliseconds: 300),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history,
              color: selectedIndex == 1 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Visited',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add,
              color: selectedIndex == 2 ? Colors.blueAccent : Colors.grey,
            ),
            label: 'Add',
          ),
        ],
        onDestinationSelected: (int index) {
          final goRouter = GoRouter.of(context);
          goRouter.go(_navItems[index]);
        },
      ),
    );
  }
}
