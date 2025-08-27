import 'package:dio/dio.dart';

class WeatherApiService {
  final Dio dio;

  WeatherApiService({required this.dio});

  Future<Map<String, dynamic>> fetchWeather(
    double lat,
    double lon,
    String apiKey,
  ) async {
    const String url = 'https://api.openweathermap.org/data/2.5/onecall';

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'exclude': 'hourly,minutely,current,alerts',
          'appid': apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
