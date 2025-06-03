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
      'accommodationSuggestions':
          accommodationSuggestions.map((x) => x.toMap()).toList(),
      'transportationDetails': transportationDetails.toMap(),
      'foodRecommendations': foodRecommendations,
      'additionalTips': additionalTips,
      'budget': budget,
      'isFavorite': isFavorite,
    };
  }

  factory TravelDbModel.fromMap(Map<String, dynamic> map) {
    return TravelDbModel(
      travelId: map['travelId'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      destination: map['destination'] ?? '',
      currentLocation: map['currentLocation'] ?? '',
      tripType: map['tripType'] ?? '',
      startDate: (map['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (map['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalDays: map['totalDays'] is int ? map['totalDays'] : 0,
      totalPeople: map['totalPeople'] is int ? map['totalPeople'] : 0,
      overview: map['overview'] ?? '',
      dailyPlan:
          (map['dailyPlan'] as List<dynamic>?)
              ?.map((e) => DayPlan.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      accommodationSuggestions:
          (map['accommodationSuggestions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    AccommodationSuggestion.fromMap(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      transportationDetails:
          map['transportationDetails'] != null
              ? TransportationDetails.fromMap(
                map['transportationDetails'] as Map<String, dynamic>,
              )
              : TransportationDetails.empty(),
      foodRecommendations: List<String>.from(map['foodRecommendations'] ?? []),
      additionalTips: List<String>.from(map['additionalTips'] ?? []),
      budget: map['budget'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  @override
  String toString() {
    return 'TravelDbModel{travelId: $travelId, userId: $userId, createdAt: $createdAt, destination: $destination, currentLocation: $currentLocation, tripType: $tripType, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, totalPeople: $totalPeople, overview: $overview, dailyPlan: $dailyPlan, accommodationSuggestions: $accommodationSuggestions, transportationDetails: $transportationDetails, foodRecommendations: $foodRecommendations, additionalTips: $additionalTips, budget: $budget, isFavorite: $isFavorite}';
  }
}
