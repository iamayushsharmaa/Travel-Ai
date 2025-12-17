import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entity/weather_entity.dart';
import '../remote/weather_api_service.dart';
import '../repository/weather_repository.dart';
import '../repository/weather_repository_imp.dart';

part 'weather_provider.g.dart';

@riverpod
Dio dio(DioRef ref) => Dio();

@riverpod
WeatherApiService weatherApiService(WeatherApiServiceRef ref) {
  return WeatherApiService(dio: ref.read(dioProvider));
}

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return WeatherRepositoryImpl(
    apiService: ref.read(weatherApiServiceProvider),
  );
}

@riverpod
Future<WeatherEntity> weatherForecast(
  WeatherForecastRef ref,
  double lat,
  double lon,
) {
  final repo = ref.read(weatherRepositoryProvider);
  return repo.getCurrentWeather(lat, lon);
}
