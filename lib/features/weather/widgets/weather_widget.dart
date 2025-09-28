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

  IconData _getIcon(String label) {
    switch (label.toLowerCase()) {
      case 'humidity':
        return Icons.opacity;
      case 'feels like':
        return Icons.thermostat_outlined;
      case 'windspeed':
        return Icons.air;
      case 'temp min':
        return Icons.arrow_downward;
      case 'temp max':
        return Icons.arrow_upward;
      case 'temperature':
        return Icons.thermostat;
      default:
        return Icons.wb_sunny_rounded;
    }
  }

  Color _getIconColor(String label) {
    switch (label.toLowerCase()) {
      case 'humidity':
        return Colors.blue;
      case 'feels like':
        return Colors.orange;
      case 'windspeed':
        return Colors.green;
      case 'temp min':
        return Colors.blueAccent;
      case 'temp max':
        return Colors.redAccent;
      case 'temperature':
        return Colors.deepOrange;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Temperature', 'value': '${forecast.temperature}°C'},
      {'label': 'Feels Like', 'value': '${forecast.feelsLike}°C'},
      {'label': 'Humidity', 'value': '${forecast.humidity}%'},
      {'label': 'WindSpeed', 'value': '${forecast.windSpeed} m/s'},
      {'label': 'Temp Min', 'value': '${forecast.tempMin}°C'},
      {'label': 'Temp Max', 'value': '${forecast.tempMax}°C'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top container for title
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Text(
            'Weather in $destination',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        // Card with grid
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getIcon(item['label']!),
                      size: 30,
                      color: _getIconColor(item['label']!),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['value']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
