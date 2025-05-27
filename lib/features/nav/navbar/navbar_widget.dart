import 'package:flutter/material.dart';

import 'notifier.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedIndex, child) {
        return NavigationBar(
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
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedIndex,
        );
      },
    );
  }
}
