class TravelGeminiResponse {
  final String travelId;
  final String destination;
  final int days;
  final List<String> placesToVisit;

  TravelGeminiResponse({
    required this.travelId,
    required this.destination,
    required this.days,
    required this.placesToVisit,
  });

  Map<String, dynamic> toMap() {
    return {
      'travelId': this.travelId,
      'destination': this.destination,
      'days': this.days,
      'placesToVisit': this.placesToVisit,
    };
  }

  @override
  String toString() {
    return 'TravelGeminiResponse{travelId: $travelId, destination: $destination, days: $days, placesToVisit: $placesToVisit}';
  }

  factory TravelGeminiResponse.fromMap(Map<String, dynamic> map) {
    return TravelGeminiResponse(
      travelId: map['travelId'] as String,
      destination: map['destination'] as String,
      days: map['days'] as int,
      placesToVisit: List<String>.from(map['placesToVisit']),
    );
  }

  TravelGeminiResponse copyWith({
    String? travelId,
    String? destination,
    int? days,
    List<String>? placesToVisit,
  }) {
    return TravelGeminiResponse(
      travelId: travelId ?? this.travelId,
      destination: destination ?? this.destination,
      days: days ?? this.days,
      placesToVisit: placesToVisit ?? this.placesToVisit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelGeminiResponse &&
          runtimeType == other.runtimeType &&
          travelId == other.travelId &&
          destination == other.destination &&
          days == other.days &&
          placesToVisit == other.placesToVisit;

  @override
  int get hashCode =>
      travelId.hashCode ^
      destination.hashCode ^
      days.hashCode ^
      placesToVisit.hashCode;
}
