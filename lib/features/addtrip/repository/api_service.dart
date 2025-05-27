import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/addtrip/models/gemini_response_model.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_model.dart';

part 'api_service.g.dart';

@riverpod
GeminiApiService geminiApiService(GeminiApiServiceRef ref) {
  return GeminiApiService();
}

class GeminiApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: '${dotenv.env["BASE_URL"]}'));
  final String _apiKey = '${dotenv.env["API_KEY"]}';

  Future<TravelGeminiResponse> getGeminiComplete(String prompt) async {
    try {
      final response = await dio.post(
        'gemini-2.0-flash:generateContent?key=$_apiKey',
        data: {
          "content": [
            {
              "parts": [
                {"text": "$prompt"},
              ],
            },
          ],
        },
      );
      final geminiResponse = GeminiResponse.fromJsom(response.data);

      final rawText =
          geminiResponse.candidates.first.content.parts.first.text.trim();

      final decodedJson = json.decode(rawText);
      final trips = (decodedJson['tripSuggestions']).map(
        (e) => TravelGeminiResponse.fromJson(e),
      );
      return trips;
    } on DioException catch (e) {
      throw Exception(
        'Dio error: ${e.response?.statusCode} - ${e.response?.data}',
      );
    } catch (e) {
      throw Exception('Parsing error: $e');
    }
  }
}
