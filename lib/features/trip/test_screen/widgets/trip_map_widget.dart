
import 'package:flutter/material.dart';

class TripMapWidget extends StatelessWidget {
  final double currentLat;
  final double currentLng;
  final double destinationLat;
  final double destinationLng;
  final String destinationName;
  final double height;

  const TripMapWidget({
    super.key,
    required this.currentLat,
    required this.currentLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationName,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    // Use your existing TripMap widget here
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text('Map Widget'),
      ),
    );
  }
}