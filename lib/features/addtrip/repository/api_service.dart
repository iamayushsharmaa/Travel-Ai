import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/addtrip/models/gemini_response_model.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

part 'api_service.g.dart';

@riverpod
GeminiApiService geminiApiService(GeminiApiServiceRef ref) {
  return GeminiApiService();
}

class GeminiApiService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? 'https://generativelanguage.googleapis.com/v1beta/models/',
  ));
  final String _apiKey = dotenv.env['API_KEY'] ?? '';

  Future<TravelGeminiResponse> getGeminiComplete(String prompt) async {
    try {
      // Make API call to Gemini
      final response = await dio.post(
        'gemini-1.5-flash:generateContent?key=$_apiKey',
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
      final rawText = geminiResponse.candidates.first.content.parts.first.text.trim();

      // Parse JSON response
      Map<String, dynamic> decodedJson;
      try {
        decodedJson = json.decode(rawText);
      } catch (e) {
        print('Raw response: $rawText');
        throw Exception('Failed to parse response as JSON: $e');
      }

      // Validate required fields
      if (!decodedJson.containsKey('destination') ||
          !decodedJson.containsKey('dailyPlan')) {
        throw Exception('Invalid response format: Missing required fields');
      }

      // Compute totalDays and totalPeople if not provided
      final startDate = DateTime.parse(decodedJson['startDate'] as String);
      final endDate = DateTime.parse(decodedJson['endDate'] as String);
      decodedJson['totalDays'] = decodedJson['totalDays'] ?? endDate.difference(startDate).inDays + 1;
      decodedJson['totalPeople'] = decodedJson['totalPeople'] ?? 1;
      decodedJson['tripType'] = decodedJson['tripType'] ?? 'Unknown';
      decodedJson['budget'] = decodedJson['budget'] ?? 'Unknown';

      // Parse into TravelGeminiResponse
      final trip = TravelGeminiResponse.fromJson(decodedJson);
      return trip;
    } on DioException catch (e) {
      throw Exception(
        'Dio error: ${e.response?.statusCode} - ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}