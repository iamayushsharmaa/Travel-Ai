import 'package:triptide/features/weather/data/model/weather_model.dart';

import '../../data/remote/weather_api_service.dart';
import '../../data/repository/weather_repository.dart';
import '../entity/weather_entity.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;
  final String apiKey;

  WeatherRepositoryImpl({required this.apiService, required this.apiKey});

  @override
  Future<List<WeatherEntity>> getWeatherForecast(double lat, double lon) async {
    final jsonData = await apiService.fetchWeather(lat, lon, apiKey);

    final List<dynamic> dailyData = jsonData['daily'];
    return dailyData.map((e) => WeatherModel.fromJson(e)).toList();
  }
}
