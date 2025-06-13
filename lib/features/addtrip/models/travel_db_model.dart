import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

part 'travel_db_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TravelDbModel extends Equatable {
  final String travelId;
  final String userId;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;
  final String destination;
  final String destinationLowerCase;
  final String? currentLocation;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime startDate;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime endDate;
  final String? overview;
  final String? tripType;
  final int totalDays;
  final int totalPeople;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String? budget;
  final bool isFavorite;

  TravelDbModel({
    required this.travelId,
    required this.userId,
    required this.createdAt,
    required this.destination,
    required this.destinationLowerCase,
    this.currentLocation,
    required this.startDate,
    required this.endDate,
    this.overview,
    this.tripType,
    required this.totalDays,
    required this.totalPeople,
    this.dailyPlan = const [],
    this.accommodationSuggestions = const [],
    required this.transportationDetails,
    this.foodRecommendations = const [],
    this.additionalTips = const [],
    this.budget,
    this.isFavorite = false,
  });

  factory TravelDbModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$TravelDbModelFromJson({
        ...json,
        'destination': json['destination'] ?? '',
        'destinationLowerCase': json['destinationLowerCase'] ?? (json['destination'] as String? ?? '').toLowerCase(),
        'currentLocation': json['currentLocation'] ?? '',
        'overview': json['overview'] ?? '',
        'tripType': json['tripType'] ?? '',
        'budget': json['budget'] ?? '',
      });
    } catch (e) {
      print('Error parsing TravelDbModel: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() => _$TravelDbModelToJson(this);

  @override
  List<Object?> get props => [
    travelId,
    userId,
    createdAt,
    destination,
    destinationLowerCase,
    currentLocation,
    startDate,
    endDate,
    overview,
    tripType,
    totalDays,
    totalPeople,
    dailyPlan,
    accommodationSuggestions,
    transportationDetails,
    foodRecommendations,
    additionalTips,
    budget,
    isFavorite,
  ];

  static DateTime _dateTimeFromString(String? date) =>
      date != null && date.isNotEmpty ? DateTime.parse(date) : DateTime.now();
  static String _dateTimeToString(DateTime date) => date.toIso8601String();
  static DateTime _dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate() ?? DateTime.now();
  static Timestamp _dateTimeToTimestamp(DateTime date) =>
      Timestamp.fromDate(date);
}
