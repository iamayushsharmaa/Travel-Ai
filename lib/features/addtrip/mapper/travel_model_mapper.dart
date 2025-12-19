import '../../../core/enums/trip_status.dart';
import '../models/travel_db_model.dart';
import '../models/travel_gemini_response.dart';

class TravelDbMapper {
  static TravelDbModel fromGemini({
    required TravelGeminiResponse ai,
    required String userId,
    required String travelId,
  }) {
    return TravelDbModel(
      travelId: travelId,
      userId: userId,
      createdAt: DateTime.now(),

      destination: ai.destination,
      destinationLowerCase: ai.destination.toLowerCase(),

      currentLocation: ai.currentLocation,
      currentLat: ai.currentLat,
      currentLng: ai.currentLng,
      destinationLat: ai.destinationLat,
      destinationLng: ai.destinationLng,

      startDate: ai.startDate,
      endDate: ai.endDate,

      overview: ai.overview,
      tripType: ai.tripType,
      totalDays: ai.totalDays,
      totalPeople: ai.totalPeople,

      images: ai.images,
      dailyPlan: ai.dailyPlan,
      accommodationSuggestions: ai.accommodationSuggestions,
      transportationDetails: ai.transportationDetails,
      foodRecommendations: ai.foodRecommendations,
      additionalTips: ai.additionalTips,
      budget: ai.budget,

      isFavorite: false,

      status: TripStatus.planned,
      visitedAt: null,
    );
  }
}
