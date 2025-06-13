// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelDbModel _$TravelDbModelFromJson(Map<String, dynamic> json) =>
    TravelDbModel(
      travelId: json['travelId'] as String,
      userId: json['userId'] as String,
      createdAt: TravelDbModel._dateTimeFromTimestamp(
        json['createdAt'] as Timestamp,
      ),
      destination: json['destination'] as String,
      currentLocation: json['currentLocation'] as String,
      startDate: TravelDbModel._dateTimeFromString(json['startDate'] as String),
      endDate: TravelDbModel._dateTimeFromString(json['endDate'] as String),
      overview: json['overview'] as String,
      tripType: json['tripType'] as String,
      totalDays: (json['totalDays'] as num).toInt(),
      totalPeople: (json['totalPeople'] as num).toInt(),
      dailyPlan:
          (json['dailyPlan'] as List<dynamic>)
              .map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
              .toList(),
      accommodationSuggestions:
          (json['accommodationSuggestions'] as List<dynamic>)
              .map(
                (e) =>
                    AccommodationSuggestion.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      transportationDetails: TransportationDetails.fromJson(
        json['transportationDetails'] as Map<String, dynamic>,
      ),
      foodRecommendations:
          (json['foodRecommendations'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      additionalTips:
          (json['additionalTips'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      budget: json['budget'] as String,
      isFavorite: json['isFavorite'] as bool,
    );

Map<String, dynamic> _$TravelDbModelToJson(TravelDbModel instance) =>
    <String, dynamic>{
      'travelId': instance.travelId,
      'userId': instance.userId,
      'createdAt': TravelDbModel._dateTimeToTimestamp(instance.createdAt),
      'destination': instance.destination,
      'currentLocation': instance.currentLocation,
      'startDate': TravelDbModel._dateTimeToString(instance.startDate),
      'endDate': TravelDbModel._dateTimeToString(instance.endDate),
      'overview': instance.overview,
      'tripType': instance.tripType,
      'totalDays': instance.totalDays,
      'totalPeople': instance.totalPeople,
      'dailyPlan': instance.dailyPlan,
      'accommodationSuggestions': instance.accommodationSuggestions,
      'transportationDetails': instance.transportationDetails,
      'foodRecommendations': instance.foodRecommendations,
      'additionalTips': instance.additionalTips,
      'budget': instance.budget,
      'isFavorite': instance.isFavorite,
    };
