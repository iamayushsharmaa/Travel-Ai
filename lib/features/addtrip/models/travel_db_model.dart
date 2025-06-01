import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_model.dart';

class TravelDbModel {
  final String travelId;
  final String userId;
  final DateTime? createdAt;
  final String destination;
  final String currentLocation;
  final String tripType;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final int totalPeople;
  final String overview;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String budget;
  final bool isFavorite;

  TravelDbModel({
    required this.travelId,
    required this.userId,
    required this.createdAt,
    required this.destination,
    required this.currentLocation,
    required this.tripType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.totalPeople,
    required this.overview,
    required this.dailyPlan,
    required this.accommodationSuggestions,
    required this.transportationDetails,
    required this.foodRecommendations,
    required this.additionalTips,
    required this.budget,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'travelId': travelId,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
      'destination': destination,
      'currentLocation': currentLocation,
      'tripType': tripType,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'totalDays': totalDays,
      'totalPeople': totalPeople,
      'overview': overview,
      'dailyPlan': dailyPlan.map((x) => x.toMap()).toList(),
      'accommodationSuggestions': accommodationSuggestions.map((x) => x.toMap()).toList(),
      'transportationDetails': transportationDetails.toMap(),
      'foodRecommendations': foodRecommendations,
      'additionalTips': additionalTips,
      'budget': budget,
      'isFavorite': isFavorite,
    };
  }

  factory TravelDbModel.fromMap(Map<String, dynamic> map) {
    return TravelDbModel(
      travelId: map['travelId'] as String,
      userId: map['userId'] as String,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      destination: map['destination'] as String,
      currentLocation: map['currentLocation'] as String,
      tripType: map['tripType'] as String,
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      totalDays: map['totalDays'] as int,
      totalPeople: map['totalPeople'] as int,
      overview: map['overview'] as String,

      dailyPlan: (map['dailyPlan'] as List<dynamic>)
          .map((e) => DayPlan.fromMap(e as Map<String, dynamic>))
          .toList(),

      accommodationSuggestions: (map['accommodationSuggestions'] as List<dynamic>)
          .map((e) => AccommodationSuggestion.fromMap(e as Map<String, dynamic>))
          .toList(),

      transportationDetails: TransportationDetails.fromMap(
        map['transportationDetails'] as Map<String, dynamic>,
      ),

      foodRecommendations: List<String>.from(map['foodRecommendations'] ?? []),

      additionalTips: List<String>.from(map['additionalTips'] ?? []),

      budget: map['budget'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }




  @override
  String toString() {
    return 'TravelDbModel{travelId: $travelId, userId: $userId, createdAt: $createdAt, destination: $destination, currentLocation: $currentLocation, tripType: $tripType, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, totalPeople: $totalPeople, overview: $overview, dailyPlan: $dailyPlan, accommodationSuggestions: $accommodationSuggestions, transportationDetails: $transportationDetails, foodRecommendations: $foodRecommendations, additionalTips: $additionalTips, budget: $budget, isFavorite: $isFavorite}';
  }
}
