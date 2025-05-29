import 'package:triptide/features/addtrip/models/travel_gemini_model.dart';

class TravelDbModel {
  final String travelId;
  final String userId;
  final DateTime? createdAt;
  final String destination;
  final String currentLocation;
  final DateTime startDate;
  final DateTime endDate;
  final String overview;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String budget;

  TravelDbModel({
    required this.travelId,
    required this.userId,
    required this.createdAt,
    required this.destination,
    required this.currentLocation,
    required this.startDate,
    required this.endDate,
    required this.overview,
    required this.dailyPlan,
    required this.accommodationSuggestions,
    required this.transportationDetails,
    required this.foodRecommendations,
    required this.additionalTips,
    required this.budget,
  });

  Map<String, dynamic> toMap() {
    return {
      'travelId': this.travelId,
      'userId': this.userId,
      'createdAt': this.createdAt,
      'destination': this.destination,
      'currentLocation': this.currentLocation,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'overview': this.overview,
      'dailyPlan': this.dailyPlan,
      'accommodationSuggestions': this.accommodationSuggestions,
      'transportationDetails': this.transportationDetails,
      'foodRecommendations': this.foodRecommendations,
      'additionalTips': this.additionalTips,
      'budget': this.budget,
    };
  }

  factory TravelDbModel.fromMap(Map<String, dynamic> map) {
    return TravelDbModel(
      travelId: map['travelId'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as DateTime,
      destination: map['destination'] as String,
      currentLocation: map['currentLocation'] as String,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
      overview: map['overview'] as String,
      dailyPlan: map['dailyPlan'] as List<DayPlan>,
      accommodationSuggestions:
          map['accommodationSuggestions'] as List<AccommodationSuggestion>,
      transportationDetails:
          map['transportationDetails'] as TransportationDetails,
      foodRecommendations: map['foodRecommendations'] as List<String>,
      additionalTips: map['additionalTips'] as List<String>,
      budget: map['budget'] as String,
    );
  }

  TravelDbModel copyWith({
    String? travelId,
    String? userId,
    DateTime? createdAt,
    String? destination,
    String? currentLocation,
    DateTime? startDate,
    DateTime? endDate,
    String? overview,
    List<DayPlan>? dailyPlan,
    List<AccommodationSuggestion>? accommodationSuggestions,
    TransportationDetails? transportationDetails,
    List<String>? foodRecommendations,
    List<String>? additionalTips,
    String? budget,
  }) {
    return TravelDbModel(
      travelId: travelId ?? this.travelId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      destination: destination ?? this.destination,
      currentLocation: currentLocation ?? this.currentLocation,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      overview: overview ?? this.overview,
      dailyPlan: dailyPlan ?? this.dailyPlan,
      accommodationSuggestions:
          accommodationSuggestions ?? this.accommodationSuggestions,
      transportationDetails:
          transportationDetails ?? this.transportationDetails,
      foodRecommendations: foodRecommendations ?? this.foodRecommendations,
      additionalTips: additionalTips ?? this.additionalTips,
      budget: budget ?? this.budget,
    );
  }

  @override
  String toString() {
    return 'TravelDbModel{travelId: $travelId, userId: $userId, createdAt: $createdAt, destination: $destination, currentLocation: $currentLocation, startDate: $startDate, endDate: $endDate, overview: $overview, dailyPlan: $dailyPlan, accommodationSuggestions: $accommodationSuggestions, transportationDetails: $transportationDetails, foodRecommendations: $foodRecommendations, additionalTips: $additionalTips, budget: $budget}';
  }
}
