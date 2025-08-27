class WeatherForecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final int humidity;
  final double windSpeed;
  final int rainChance;

  WeatherForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.rainChance,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
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
