import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'travel_gemini_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TravelGeminiResponse extends Equatable {
  final String destination;
  final String currentLocation;
  final double destinationLat;
  final double destinationLng;
  final double currentLat;
  final double currentLng;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime startDate;
  @JsonKey(fromJson: _dateTimeFromString, toJson: _dateTimeToString)
  final DateTime endDate;
  final String overview;
  final String tripType;
  final int totalDays;
  final int totalPeople;
  final List<String> images;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String budget;

  TravelGeminiResponse({
    required this.destination,
    required this.currentLocation,
    required this.destinationLat,
    required this.destinationLng,
    required this.currentLat,
    required this.currentLng,
    required this.startDate,
    required this.endDate,
    required this.overview,
    required this.tripType,
    required this.totalDays,
    required this.totalPeople,
    required this.dailyPlan,
    required this.accommodationSuggestions,
    required this.transportationDetails,
    required this.foodRecommendations,
    required this.additionalTips,
    required this.budget,
    required this.images,
  });

  factory TravelGeminiResponse.fromJson(Map<String, dynamic> json) =>
      _$TravelGeminiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TravelGeminiResponseToJson(this);

  @override
  List<Object?> get props => [
    destination,
    currentLocation,
    startDate,
    endDate,
    overview,
    tripType,
    totalDays,
    totalPeople,
    images,
    dailyPlan,
    accommodationSuggestions,
    transportationDetails,
    foodRecommendations,
    additionalTips,
    budget,
  ];

  static DateTime _dateTimeFromString(String? date) =>
      date != null ? DateTime.parse(date) : DateTime.now();

  static String _dateTimeToString(DateTime date) => date.toIso8601String();
}

@JsonSerializable(explicitToJson: true)
class DayPlan {
  final int day;
  @JsonKey(fromJson: _dateTimeFromFirestore, toJson: _dateTimeToFirestore)
  final DateTime date;
  final List<Activity> activities;

  DayPlan({required this.day, required this.date, required this.activities});

  factory DayPlan.fromJson(Map<String, dynamic> json) =>
      _$DayPlanFromJson(json);

  Map<String, dynamic> toJson() => _$DayPlanToJson(this);

  static DateTime _dateTimeFromFirestore(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now(); // Fallback
  }

  static Timestamp _dateTimeToFirestore(DateTime date) =>
      Timestamp.fromDate(date);
}

@JsonSerializable(explicitToJson: true)
class Activity {
  final String time;
  final String description;

  Activity({required this.time, required this.description});

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AccommodationSuggestion {
  final String name;
  final String type;
  final String location;
  final String priceRange;

  AccommodationSuggestion({
    required this.name,
    required this.type,
    required this.location,
    required this.priceRange,
  });

  factory AccommodationSuggestion.fromJson(Map<String, dynamic> json) =>
      _$AccommodationSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationSuggestionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransportationDetails {
  final String localTransport;
  final String tips;

  TransportationDetails({required this.localTransport, required this.tips});

  factory TransportationDetails.fromJson(Map<String, dynamic> json) =>
      _$TransportationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TransportationDetailsToJson(this);
}
