import 'package:flutter/material.dart';

class WeatherMetricData {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const WeatherMetricData({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}
