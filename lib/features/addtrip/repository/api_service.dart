import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/constant.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

import '../../../core/utilities/normalizeGeminiResponse.dart';
import '../models/gemini_response_model.dart';

part 'api_service.g.dart';

@riverpod
GeminiApiService geminiApiService(GeminiApiServiceRef ref) {
  return GeminiApiService();
}

class GeminiApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl:
          dotenv.env['BASE_URL'] ??
          'https://generativelanguage.googleapis.com/v1beta/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  final String _apiKey = Constant.API_KEY;

  static final String _model = Constant.MODEL;

  Future<TravelGeminiResponse> getGeminiComplete(String prompt) async {
    try {
      final response = await dio.post(
        'models/$_model:generateContent?key=$_apiKey',
        data: {
          'contents': [
            {
              'role': 'user',
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        },
      );

      final geminiResponse = GeminiResponse.fromJson(response.data);

      if (geminiResponse.candidates.isEmpty ||
          geminiResponse.candidates.first.content.parts.isEmpty) {
        throw Exception('Gemini returned empty response');
      }

      final rawText =
          geminiResponse.candidates.first.content.parts.first.text.trim();

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
        'Dio error: ${e.response?.statusCode} - ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception('Gemini API error: $e');
    }
  }
}
