import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

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
          'https://generativelanguage.googleapis.com/v1/',
    ),
  );

  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<TravelGeminiResponse> getGeminiComplete(String prompt) async {
    await Future.delayed(const Duration(seconds: 1));

    return TravelGeminiResponse(
      destination: "Goa",
      currentLocation: "New Delhi",
      destinationLat: 15.2993,
      destinationLng: 74.1240,
      currentLat: 28.6139,
      currentLng: 77.2090,
      startDate: DateTime(2026, 2, 10),
      endDate: DateTime(2026, 2, 13),
      overview:
          "A relaxing beach vacation in Goa with sightseeing, leisure, and local cultural experiences.",
      tripType: "Leisure",
      totalDays: 4,
      totalPeople: 2,
      images: [
        "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
        "https://images.unsplash.com/photo-1524492412937-b28074a5d7da",
        "https://images.unsplash.com/photo-1580748141549-71748dbe0bdc",
      ],
      dailyPlan: [
        DayPlan(
          day: 1,
          date: DateTime(2026, 2, 10),
          activities: [
            Activity(
              time: "09:00 AM",
              description: "Arrival in Goa and hotel check-in",
            ),
            Activity(time: "12:00 PM", description: "Relax at Calangute Beach"),
            Activity(
              time: "07:00 PM",
              description: "Dinner at a beachside restaurant",
            ),
          ],
        ),
        DayPlan(
          day: 2,
          date: DateTime(2026, 2, 11),
          activities: [
            Activity(
              time: "10:00 AM",
              description: "Visit Fort Aguada and nearby viewpoints",
            ),
            Activity(
              time: "02:00 PM",
              description: "Lunch at a local Goan café",
            ),
            Activity(
              time: "06:00 PM",
              description: "Sunset cruise on Mandovi River",
            ),
          ],
        ),
        DayPlan(
          day: 3,
          date: DateTime(2026, 2, 12),
          activities: [
            Activity(time: "09:30 AM", description: "Explore Old Goa churches"),
            Activity(
              time: "01:00 PM",
              description: "Shopping at local markets",
            ),
            Activity(time: "08:00 PM", description: "Nightlife at Baga Beach"),
          ],
        ),
        DayPlan(
          day: 4,
          date: DateTime(2026, 2, 13),
          activities: [
            Activity(time: "10:00 AM", description: "Breakfast and checkout"),
            Activity(time: "01:00 PM", description: "Departure from Goa"),
          ],
        ),
      ],
      accommodationSuggestions: [
        AccommodationSuggestion(
          name: "Seaside Resort Goa",
          type: "Resort",
          location: "Calangute",
          priceRange: "₹4,000 – ₹6,000 per night",
        ),
        AccommodationSuggestion(
          name: "Budget Beach Stay",
          type: "Hotel",
          location: "Baga",
          priceRange: "₹2,000 – ₹3,000 per night",
        ),
      ],
      transportationDetails: TransportationDetails(
        localTransport:
            "Scooters, taxis, and app-based cabs are widely available.",
        tips:
            "Renting a scooter is the most convenient and affordable way to explore Goa.",
      ),
      foodRecommendations: [
        "Goan Fish Curry",
        "Prawn Balchão",
        "Bebinca dessert",
        "Seafood thali",
      ],
      additionalTips: [
        "Carry sunscreen and light clothing",
        "Avoid peak afternoon sun for outdoor activities",
        "Book popular activities in advance",
      ],
      budget: "₹30,000 – ₹40,000 (excluding flights)",
    );

    // try {
    //   final response = await dio.post(
    //     'models/gemini-2.0-flash:generateContent?key=$_apiKey',
    //     data: {
    //       'contents': [
    //         {
    //           'role': 'user',
    //           'parts': [
    //             {'text': prompt},
    //           ],
    //         },
    //       ],
    //     },
    //   );
    //
    //   final geminiResponse = GeminiResponse.fromJson(response.data);
    //
    //   if (geminiResponse.candidates.isEmpty ||
    //       geminiResponse.candidates.first.content.parts.isEmpty) {
    //     throw Exception('Gemini returned empty response');
    //   }
    //
    //   final rawText =
    //       geminiResponse.candidates.first.content.parts.first.text.trim();
    //
    //   // Remove markdown code blocks if present
    //   final cleanedText =
    //       rawText
    //           .replaceAll(RegExp(r'```json|```', caseSensitive: false), '')
    //           .trim();
    //
    //   Map<String, dynamic> decodedJson;
    //   try {
    //     decodedJson = json.decode(cleanedText);
    //   } catch (e) {
    //     print('Raw Gemini response:\n$rawText');
    //     throw Exception('Failed to parse Gemini JSON: $e');
    //   }
    //
    //   decodedJson = GeminiResponseUtils.normalizeGeminiResponse(decodedJson);
    //
    //
    //
    //   return TravelGeminiResponse.fromJson(decodedJson);
    // } on DioException catch (e) {
    //   throw Exception(
    //     'Dio error: ${e.response?.statusCode} - '
    //     '${e.response?.data ?? e.message}',
    //   );
    // } catch (e) {
    //   throw Exception('Gemini parsing error: $e');
    // }
  }
}
