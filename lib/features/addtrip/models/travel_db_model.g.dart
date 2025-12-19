// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_db_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelDbModel _$TravelDbModelFromJson(
  Map<String, dynamic> json,
) => TravelDbModel(
  travelId: json['travelId'] as String,
  userId: json['userId'] as String,
  createdAt: TravelDbModel._dateTimeFromTimestamp(
    json['createdAt'] as Timestamp?,
  ),
  destination: json['destination'] as String,
  destinationLowerCase: json['destinationLowerCase'] as String,
  currentLocation: json['currentLocation'] as String?,
  currentLat: (json['currentLat'] as num?)?.toDouble(),
  currentLng: (json['currentLng'] as num?)?.toDouble(),
  destinationLat: (json['destinationLat'] as num?)?.toDouble(),
  destinationLng: (json['destinationLng'] as num?)?.toDouble(),
  startDate: TravelDbModel._dateTimeFromString(json['startDate'] as String?),
  endDate: TravelDbModel._dateTimeFromString(json['endDate'] as String?),
  overview: json['overview'] as String?,
  tripType: json['tripType'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  totalDays: (json['totalDays'] as num).toInt(),
  totalPeople: (json['totalPeople'] as num).toInt(),
  dailyPlan:
      (json['dailyPlan'] as List<dynamic>?)
          ?.map((e) => DayPlan.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  accommodationSuggestions:
      (json['accommodationSuggestions'] as List<dynamic>?)
          ?.map(
            (e) => AccommodationSuggestion.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  transportationDetails: TransportationDetails.fromJson(
    json['transportationDetails'] as Map<String, dynamic>,
  ),
  foodRecommendations:
      (json['foodRecommendations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  additionalTips:
      (json['additionalTips'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  budget: json['budget'] as String?,
  isFavorite: json['isFavorite'] as bool? ?? false,
  status: TravelDbModel._tripStatusFromJson(json['status'] as String?),
  visitedAt: TravelDbModel._dateTimeFromTimestampNullable(
    json['visitedAt'] as Timestamp?,
  ),
);

Map<String, dynamic> _$TravelDbModelToJson(
  TravelDbModel instance,
) => <String, dynamic>{
  'travelId': instance.travelId,
  'userId': instance.userId,
  'createdAt': TravelDbModel._dateTimeToTimestamp(instance.createdAt),
  'destination': instance.destination,
  'destinationLowerCase': instance.destinationLowerCase,
  'currentLocation': instance.currentLocation,
  'currentLat': instance.currentLat,
  'currentLng': instance.currentLng,
  'destinationLat': instance.destinationLat,
  'destinationLng': instance.destinationLng,
  'startDate': TravelDbModel._dateTimeToString(instance.startDate),
  'endDate': TravelDbModel._dateTimeToString(instance.endDate),
  'overview': instance.overview,
  'tripType': instance.tripType,
  'totalDays': instance.totalDays,
  'totalPeople': instance.totalPeople,
  'images': instance.images,
  'dailyPlan': instance.dailyPlan.map((e) => e.toJson()).toList(),
  'accommodationSuggestions':
      instance.accommodationSuggestions.map((e) => e.toJson()).toList(),
  'transportationDetails': instance.transportationDetails.toJson(),
  'foodRecommendations': instance.foodRecommendations,
  'additionalTips': instance.additionalTips,
  'budget': instance.budget,
  'isFavorite': instance.isFavorite,
  'status': TravelDbModel._tripStatusToJson(instance.status),
  'visitedAt': TravelDbModel._dateTimeToTimestampNullable(instance.visitedAt),
};
