import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/utilities/normalizeGeminiResponse.dart';
import 'package:triptide/features/addtrip/models/gemini_response_model.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

part 'api_service.g.dart';

@riverpod
GeminiApiService geminiApiService(GeminiApiServiceRef ref) {
  return GeminiApiService();
}

class GeminiApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://generativelanguage.googleapis.com/v1beta/models/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<TravelGeminiResponse> getGeminiComplete(String prompt) async {
    try {
      final response = await dio.post(
        'gemini-1.5-flash:generateContent',
        queryParameters: {'key': _apiKey},
        data: {
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': prompt},
              ],
            },
          ],
          'generationConfig': {'responseMimeType': 'application/json'},
        },
      );

      final geminiResponse = GeminiResponse.fromJson(response.data);

      if (geminiResponse.candidates.isEmpty ||
          geminiResponse.candidates.first.content.parts.isEmpty) {
        throw Exception('Gemini returned empty response');
      }

      final rawText =
          geminiResponse.candidates.first.content.parts.first.text.trim();

      // Remove markdown code blocks if present
      final cleanedText =
          rawText
              .replaceAll(RegExp(r'```json|```', caseSensitive: false), '')
              .trim();

      Map<String, dynamic> decodedJson;
      try {
        decodedJson = json.decode(cleanedText);
      } catch (e) {
        print('Raw Gemini response:\n$rawText');
        throw Exception('Failed to parse Gemini JSON: $e');
      }

      decodedJson = GeminiResponseUtils.normalizeGeminiResponse(decodedJson);

      return TravelGeminiResponse.fromJson(decodedJson);
    } on DioException catch (e) {
      throw Exception(
        'Dio error: ${e.response?.statusCode} - '
        '${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception('Gemini parsing error: $e');
    }
  }
}
