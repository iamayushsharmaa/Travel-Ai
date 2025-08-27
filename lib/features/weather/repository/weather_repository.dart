import 'package:triptide/core/type_def.dart';

import '../../domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<List<WeatherEntity>> getWeatherForecast(double lat, double lon);
}
