import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  final String route;
  final String tripType;
  final String peopleCount;
  final String duration;

  const OverviewCard({
    Key? key,
    required this.route,
    required this.tripType,
    required this.peopleCount,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.indigo.shade700;
    final accentColor = Colors.indigo.shade400;

    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [primaryColor, accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          IconTextDesign(
            text: route,
            icon: const Icon(Icons.flight, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          IconTextDesign(
            text: tripType,
            icon: Icon(
              getTripTypeIcon(tripType),
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          IconTextDesign(
            text: peopleCount,
            icon: const Icon(Icons.people, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          IconTextDesign(
            text: duration,
            icon: const Icon(Icons.access_time, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

class IconTextDesign extends StatelessWidget {
  final String text;
  final Icon icon;

  const IconTextDesign({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

/// Example helper function for trip type icons
IconData getTripTypeIcon(String type) {
  switch (type.toLowerCase()) {
    case 'business':
      return Icons.work_outline;
    case 'leisure':
      return Icons.beach_access;
    case 'adventure':
      return Icons.terrain;
    default:
      return Icons.trip_origin;
  }
}
