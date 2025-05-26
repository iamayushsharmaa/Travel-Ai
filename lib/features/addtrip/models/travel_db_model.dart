import 'package:triptide/features/addtrip/models/travel_gemini_model.dart';

class TravelDbModel {
  final String travelId;
  final String userId;
  final TravelGeminiResponse tripPlan;

  TravelDbModel({
    required this.travelId,
    required this.userId,
    required this.tripPlan,
  });

  TravelDbModel copyWith({
    String? travelId,
    String? userId,
    TravelGeminiResponse? tripPlan,
  }) {
    return TravelDbModel(
      travelId: travelId ?? this.travelId,
      userId: userId ?? this.userId,
      tripPlan: tripPlan ?? this.tripPlan,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'travelId': this.travelId,
      'userId': this.userId,
      'tripPlan': this.tripPlan,
    };
  }

  factory TravelDbModel.fromMap(Map<String, dynamic> map) {
    return TravelDbModel(
      travelId: map['travelId'] as String,
      userId: map['userId'] as String,
      tripPlan: map['tripPlan'] as TravelGeminiResponse,
    );
  }
}
