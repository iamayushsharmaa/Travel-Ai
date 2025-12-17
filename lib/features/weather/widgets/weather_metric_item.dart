import 'package:flutter/material.dart';

import '../entity/weather_metric_data.dart';

class WeatherMetricItem extends StatelessWidget {
  final WeatherMetricData metric;

  const WeatherMetricItem({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(metric.icon, size: 30, color: metric.color),
        const SizedBox(height: 8),
        Text(
          metric.value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          metric.label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }
}
