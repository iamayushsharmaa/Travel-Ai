import 'package:flutter/material.dart';
import 'package:triptide/features/trip/test_screen/widgets/section_header.dart';
import 'package:triptide/features/trip/test_screen/widgets/trip_map_widget.dart';

class MapSection extends StatelessWidget {
  final double currentLat;
  final double currentLng;
  final double destinationLat;
  final double destinationLng;
  final String destinationName;

  const MapSection({
    super.key,
    required this.currentLat,
    required this.currentLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.map_outlined, title: 'Route Map'),
        const SizedBox(height: 16),
        TripMapWidget(
          currentLat: currentLat,
          currentLng: currentLng,
          destinationLat: destinationLat,
          destinationLng: destinationLng,
          destinationName: destinationName,
          height: 250,
        ),
      ],
    );
  }
}
