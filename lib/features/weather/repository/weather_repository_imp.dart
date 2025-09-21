import 'package:triptide/features/weather/repository/weather_repository.dart';

import '../entity/weather_entity.dart';
import '../model/weather_model.dart';
import '../remote/weather_api_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;
  final String apiKey;

  WeatherRepositoryImpl({required this.apiService, required this.apiKey});

  @override
  Future<List<WeatherEntity>> getWeatherForecast(
    double? lat,
    double? lon,
  ) async {
    final jsonData = await apiService.fetchWeather(lat, lon, apiKey);

    final List<dynamic> dailyData = jsonData['daily'];
    return dailyData.map((e) => WeatherModel.fromJson(e)).toList();
  }
}
