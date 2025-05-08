import 'package:dio/dio.dart';
import 'package:triptide/data/api/models/gemini_response.dart';

class GeminiApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://generativelanguage.googleapis.com/v1beta/models/',
    ),
  );

  final String _apiKey = '';

  Future<GeminiResponse> getGeminiComplete(String prompt) async {
    try {
      final response = await dio.post(
        'gemini-pro:generateContent?key=$_apiKey',
        data: {
          "content": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
        },
      );
      final candidate =
          response.data['candidates'][0]['content']['parts'][0]['text'];
      return GeminiResponse(candidate: candidate);
    } catch (e) {
      throw Exception('Failed to fetch: $e');
    }
  }
}
