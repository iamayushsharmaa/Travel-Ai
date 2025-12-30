class GeminiResponseUtils {
  static Map<String, dynamic> normalizeGeminiResponse(
    Map<String, dynamic> json,
  ) {
    json['destination'] ??= '';
    json['currentLocation'] ??= '';
    json['destinationLat'] ??= 0.0;
    json['destinationLng'] ??= 0.0;
    json['currentLat'] ??= 0.0;
    json['currentLng'] ??= 0.0;
    json['overview'] ??= '';
    json['tripType'] ??= 'adventure';
    json['budget'] ??= '';
    json['images'] ??= [];
    json['foodRecommendations'] ??= [];
    json['additionalTips'] ??= [];
    json['accommodationSuggestions'] ??= [];
    json['dailyPlan'] ??= [];

    json['transportationDetails'] ??= {'localTransport': '', 'tips': ''};

    final startDate = DateTime.tryParse(json['startDate'] ?? '');
    final endDate = DateTime.tryParse(json['endDate'] ?? '');

    json['startDate'] ??= DateTime.now().toIso8601String();
    json['endDate'] ??=
        DateTime.now().add(const Duration(days: 1)).toIso8601String();

    json['totalDays'] ??=
        startDate != null && endDate != null
            ? endDate.difference(startDate).inDays + 1
            : 1;

    json['totalPeople'] ??= 1;

    return json;
  }
}
