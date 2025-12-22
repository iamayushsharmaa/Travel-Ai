import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:triptide/features/addtrip/models/travel_gemini_response.dart';

import '../../core/enums/trip_status.dart';

part 'travel_db_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TravelDbModel extends Equatable {
  final String travelId;
  final String userId;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;
  @JsonKey(
    fromJson: _dateTimeFromTimestampNullable,
    toJson: _dateTimeToTimestampNullable,
  )
  final DateTime? updatedAt;
  final String destination;
  final String destinationLowerCase;
  final String? currentLocation;
  final double? currentLat;
  final double? currentLng;
  final double? destinationLat;
  final double? destinationLng;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime startDate;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime endDate;
  final String? overview;
  final String? tripType;
  final int totalDays;
  final int totalPeople;
  final List<String> images;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String? budget;
  final bool isFavorite;
  final String language;
  final bool generatedByAi;

  @JsonKey(fromJson: _tripStatusFromJson, toJson: _tripStatusToJson)
  final TripStatus status;

  @JsonKey(
    fromJson: _dateTimeFromTimestampNullable,
    toJson: _dateTimeToTimestampNullable,
  )
  final DateTime? visitedAt;

  const TravelDbModel({
    required this.travelId,
    required this.userId,
    required this.createdAt,
    required this.destination,
    required this.destinationLowerCase,
    this.currentLocation,
    this.currentLat,
    this.currentLng,
    this.destinationLat,
    this.destinationLng,
    required this.startDate,
    required this.endDate,
    this.overview,
    this.tripType,
    this.images = const [],
    required this.totalDays,
    required this.totalPeople,
    this.dailyPlan = const [],
    this.accommodationSuggestions = const [],
    required this.transportationDetails,
    this.foodRecommendations = const [],
    this.additionalTips = const [],
    this.budget,
    this.isFavorite = false,
    required this.status,
    this.visitedAt,
    this.updatedAt,
    required this.language,
    required this.generatedByAi,
  });

  factory TravelDbModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$TravelDbModelFromJson({
        ...json,
        'destination': json['destination'] ?? '',
        'destinationLowerCase':
            json['destinationLowerCase'] ??
            (json['destination'] as String? ?? '').toLowerCase(),
        'currentLocation': json['currentLocation'] ?? '',
        'overview': json['overview'] ?? '',
        'tripType': json['tripType'] ?? '',
        'budget': json['budget'] ?? '',
        'currentLat': (json['currentLat'] as num?)?.toDouble() ?? 0.0,
        'currentLng': (json['currentLng'] as num?)?.toDouble() ?? 0.0,
        'destinationLat': (json['destinationLat'] as num?)?.toDouble() ?? 0.0,
        'destinationLng': (json['destinationLng'] as num?)?.toDouble() ?? 0.0,
        'images':
            (json['images'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
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
    updatedAt,
    destination,
    destinationLowerCase,
    currentLocation,
    currentLat,
    currentLng,
    destinationLat,
    destinationLng,
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
    images,
    isFavorite,
    status,
    visitedAt,
    language,
    generatedByAi,
  ];

  static TripStatus _tripStatusFromJson(String? value) =>
      TripStatus.values.byName(value ?? TripStatus.planned.name);

  static String _tripStatusToJson(TripStatus status) => status.name;

  static DateTime _dateTimeFromString(String? date) =>
      date != null && date.isNotEmpty ? DateTime.parse(date) : DateTime.now();

  static String _dateTimeToString(DateTime date) => date.toIso8601String();

  static DateTime _dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate() ?? DateTime.now();

  static Timestamp _dateTimeToTimestamp(DateTime date) =>
      Timestamp.fromDate(date);

  static DateTime? _dateTimeFromTimestampNullable(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _dateTimeToTimestampNullable(DateTime? date) =>
      date != null ? Timestamp.fromDate(date) : null;
}
