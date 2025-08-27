import '../../domain/entity/weather_entity.dart';


class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.date,
    required super.minTemp,
    required super.maxTemp,
    required super.condition,
    required super.humidity,
    required super.windSpeed,
    required super.rainChance,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: _formatDate(json['dt']),
      minTemp: (json['temp']['min'] as num).toDouble(),
      maxTemp: (json['temp']['max'] as num).toDouble(),
      condition: json['weather'][0]['description'],
      humidity: json['humidity'],
      windSpeed: (json['wind_speed'] as num).toDouble(),
      rainChance: ((json['pop'] ?? 0) * 100).toInt(),
    );
  }

  static String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${date.day}-${date.month}-${date.year}";
  }
}
