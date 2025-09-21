import '../entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<List<WeatherEntity>> getWeatherForecast(double? lat, double? lon);
}
