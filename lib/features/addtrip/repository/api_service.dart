import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:triptide/features/addtrip/models/gemini_response_model.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_model.dart';

class GeminiApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: '${dotenv.env["BASE_URL"]}'));
  final String _apiKey = '${dotenv.env["API_KEY"]}';

  Future<List<TravelGeminiResponse>> getGeminiComplete(String prompt) async {
    try {
      final response = await dio.post(
        'gemini-pro:generateContent?key=$_apiKey',
        data: {
          "content": [
            {
              "parts": [
                {
                  "text":
                      "Suggest a travel plan based on: $prompt. Return a JSON with tripSuggestions containing destination, days, and placesToVisit.",
                },
              ],
            },
          ],
        },
      );
      final geminiResponse = GeminiResponse.fromJsom(response.data);

      final rawText =
          geminiResponse.candidates.first.content.parts.first.text.trim();

      final decodedJson = json.decode(rawText);
      final trips =
          (decodedJson['tripSuggestions'] as List)
              .map((e) => TravelGeminiResponse.fromMap(e))
              .toList();

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
