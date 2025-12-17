import 'package:flutter/material.dart';

class WeatherHeader extends StatelessWidget {
  final String destination;

  const WeatherHeader({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Text(
        'Weather in $destination',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
