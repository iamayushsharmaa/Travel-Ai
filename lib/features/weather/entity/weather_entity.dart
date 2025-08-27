class WeatherEntity {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final int humidity;
  final double windSpeed;
  final int rainChance;

  const WeatherEntity({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.rainChance,
  });
}
