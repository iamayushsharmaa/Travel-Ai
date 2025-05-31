import 'package:flutter/material.dart';
import 'package:triptide/features/history/screen/trip_history.dart';

import '../addtrip/screens/add_trip.dart';
import '../home/screens/home_page.dart';
import 'navbar/navbar_widget.dart';
import 'navbar/notifier.dart';

List<Widget> pages = [HomePage(), TripHistory(), AddTripPage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
