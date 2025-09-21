import 'package:flutter/material.dart';
import 'package:triptide/features/weather/entity/weather_entity.dart';

class WeatherCard extends StatelessWidget {
  final String destination;
  final WeatherEntity forecast;

  const WeatherCard({
    Key? key,
    required this.destination,
    required this.forecast,
  }) : super(key: key);

  IconData _getWeatherIcon(String condition) {
    // You can expand this mapping based on condition text
    if (condition.toLowerCase().contains('sun')) {
      return Icons.wb_sunny_rounded;
    } else if (condition.toLowerCase().contains('cloud')) {
      return Icons.cloud_rounded;
    } else if (condition.toLowerCase().contains('rain')) {
      return Icons.grain_rounded;
    } else {
      return Icons.wb_sunny_rounded;
    }
  }

  Color _getIconColor(String condition) {
    if (condition.toLowerCase().contains('sun')) {
      return Colors.orange.shade700;
    } else if (condition.toLowerCase().contains('cloud')) {
      return Colors.blueGrey.shade400;
    } else if (condition.toLowerCase().contains('rain')) {
      return Colors.blue.shade700;
    } else {
      return Colors.orange.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _getWeatherIcon(forecast.condition),
            size: 40,
            color: _getIconColor(forecast.condition),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weather in $destination',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${forecast.condition} | ${forecast.minTemp}° / ${forecast.maxTemp}°',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rain: ${forecast.rainChance}% | Humidity: ${forecast.humidity}%',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
