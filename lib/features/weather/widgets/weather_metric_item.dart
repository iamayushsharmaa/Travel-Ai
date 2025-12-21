import 'package:flutter/material.dart';

import '../../../core/extensions/context_theme.dart';
import '../entity/weather_metric_data.dart';

class WeatherMetricItem extends StatelessWidget {
  final WeatherMetricData metric;

  const WeatherMetricItem({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          metric.icon,
          size: 30,
          color: metric.color, // metric-specific, OK to keep
        ),
        const SizedBox(height: 8),
        Text(
          metric.value,
          style: context.text.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          metric.label,
          style: context.text.bodySmall?.copyWith(
            color: context.colors.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
