class GeminiResponseUtils {
  static Map<String, dynamic> normalizeGeminiResponse(
    Map<String, dynamic> json,
  ) {
    json['destination'] ??= '';
    json['currentLocation'] ??= '';
    json['overview'] ??= '';
    json['tripType'] ??= 'Leisure';
    json['budget'] ??= '';

    json['destinationLat'] = _toDouble(json['destinationLat']) ?? 0.0;
    json['destinationLng'] = _toDouble(json['destinationLng']) ?? 0.0;
    json['currentLat'] = _toDouble(json['currentLat']) ?? 0.0;
    json['currentLng'] = _toDouble(json['currentLng']) ?? 0.0;
    json['totalPeople'] = _toInt(json['totalPeople']) ?? 1;

    json['images'] = _ensureList(json['images']);
    json['foodRecommendations'] = _ensureList(json['foodRecommendations']);
    json['additionalTips'] = _ensureList(json['additionalTips']);
    json['accommodationSuggestions'] = _ensureList(
      json['accommodationSuggestions'],
    );
    json['dailyPlan'] = _ensureList(json['dailyPlan']);

    json['transportationDetails'] =
        json['transportationDetails'] is Map
            ? json['transportationDetails']
            : {'localTransport': '', 'tips': ''};

    final now = DateTime.now();
    DateTime? startDate = _parseDate(json['startDate']);
    DateTime? endDate = _parseDate(json['endDate']);

    json['startDate'] = (startDate ?? now).toIso8601String();
    json['endDate'] =
        (endDate ?? now.add(const Duration(days: 3))).toIso8601String();

    final finalStart = DateTime.tryParse(json['startDate'] as String) ?? now;
    final finalEnd = DateTime.tryParse(json['endDate'] as String) ?? now;
    json['totalDays'] = finalEnd.difference(finalStart).inDays.abs() + 1;

    return json;
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static List<dynamic> _ensureList(dynamic value) {
    if (value is List) return value;
    return [];
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
