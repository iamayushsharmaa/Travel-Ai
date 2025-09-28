import 'package:triptide/features/weather/repository/weather_repository.dart';

import '../entity/weather_entity.dart';
import '../model/weather_model.dart';
import '../remote/weather_api_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;
  final String apiKey;

  WeatherRepositoryImpl({required this.apiService, required this.apiKey});

  @override
  Future<WeatherEntity> getCurrentWeather(double lat, double lon) async {
    final jsonData = await apiService.fetchCurrentWeather(lat: lat, lon: lon);

    final model = WeatherResponseModel.fromJson(jsonData);

    final condition = model.weather.isNotEmpty ? model.weather.first : null;

    return WeatherEntity(
      locationName: model.name,
      country: model.sys.country,
      temperature: model.main.temp,
      feelsLike: model.main.feelsLike,
      tempMin: model.main.tempMin,
      tempMax: model.main.tempMax,
      humidity: model.main.humidity,
      windSpeed: model.wind.speed,
      description: condition?.description ?? '',
      icon: condition?.icon ?? '',
    );
  }
}
