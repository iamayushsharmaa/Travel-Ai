import 'dart:math';

import 'package:flutter/material.dart';
import 'package:triptide/core/extensions/context_l10n.dart';
import 'package:triptide/features/weather/entity/weather_entity.dart';
import 'package:triptide/features/weather/widgets/weather_metric_item.dart';

import '../entity/weather_metric_data.dart';
import 'header.dart';

class WeatherCard extends StatelessWidget {
  final String destination;
  final WeatherEntity weather;

  const WeatherCard({
    super.key,
    required this.destination,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = _buildMetrics(weather, context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WeatherHeader(destination: destination),
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: metrics.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (_, index) {
                return WeatherMetricItem(metric: metrics[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  List<WeatherMetricData> _buildMetrics(WeatherEntity w, BuildContext context) {
    return [
      WeatherMetricData(
        label: context.l10n.temperature,
        value: '${w.temperature}°C',
        icon: Icons.thermostat,
        color: Colors.deepOrange,
      ),
      WeatherMetricData(
        label: context.l10n.feelsLike,
        value: '${w.feelsLike}${context.l10n.celsius}',
        icon: Icons.thermostat_outlined,
        color: Colors.orange,
      ),
      WeatherMetricData(
        label: context.l10n.humidity,
        value: '${w.humidity}%',
        icon: Icons.opacity,
        color: Colors.blue,
      ),
      WeatherMetricData(
        label: context.l10n.windSpeed,
        value: '${w.windSpeed} ${context.l10n.ms}',
        icon: Icons.air,
        color: Colors.green,
      ),
      WeatherMetricData(
        label: context.l10n.tempMin,         value: '${w.tempMin}${context.l10n.celsius}',
      icon: Icons.arrow_downward,
        color: Colors.blueAccent,
      ),
      WeatherMetricData(
        label: context.l10n.tempMax,
        value: '${w.tempMax}${context.l10n.celsius}',
        icon: Icons.arrow_upward,
        color: Colors.redAccent,
      ),
    ];
  }
}
