import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApiService {
  final Dio dio;

  WeatherApiService({required this.dio});

  Future<Map<String, dynamic>> fetchCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    const String url = 'https://api.openweathermap.org/data/2.5/weather';
    final String _apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
