class TravelGeminiResponse {
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String overview;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;

  TravelGeminiResponse({
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.overview,
    required this.dailyPlan,
    required this.accommodationSuggestions,
    required this.transportationDetails,
    required this.foodRecommendations,
    required this.additionalTips,
  });

  factory TravelGeminiResponse.fromJson(Map<String, dynamic> json) {
    return TravelGeminiResponse(
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      overview: json['overview'],
      dailyPlan: (json['dailyPlan'] as List)
          .map((e) => DayPlan.fromJson(e))
          .toList(),
      accommodationSuggestions: (json['accommodationSuggestions'] as List)
          .map((e) => AccommodationSuggestion.fromJson(e))
          .toList(),
      transportationDetails:
      TransportationDetails.fromJson(json['transportationDetails']),
      foodRecommendations:
      List<String>.from(json['foodRecommendations'] ?? []),
      additionalTips: List<String>.from(json['additionalTips'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'overview': overview,
      'dailyPlan': dailyPlan.map((e) => e.toJson()).toList(),
      'accommodationSuggestions':
      accommodationSuggestions.map((e) => e.toJson()).toList(),
      'transportationDetails': transportationDetails.toJson(),
      'foodRecommendations': foodRecommendations,
      'additionalTips': additionalTips,
    };
  }
}

class DayPlan {
  final int day;
  final String date;
  final List<Activity> activities;

  DayPlan({
    required this.day,
    required this.date,
    required this.activities,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json['day'],
      date: json['date'],
      activities:
      (json['activities'] as List).map((e) => Activity.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'date': date,
      'activities': activities.map((e) => e.toJson()).toList(),
    };
  }
}

class Activity {
  final String time;
  final String description;

  Activity({
    required this.time,
    required this.description,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      time: json['time'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'description': description,
    };
  }
}

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

  factory AccommodationSuggestion.fromJson(Map<String, dynamic> json) {
    return AccommodationSuggestion(
      name: json['name'],
      type: json['type'],
      location: json['location'],
      priceRange: json['priceRange'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'location': location,
      'priceRange': priceRange,
    };
  }
}

class TransportationDetails {
  final String localTransport;
  final String tips;

  TransportationDetails({
    required this.localTransport,
    required this.tips,
  });

  factory TransportationDetails.fromJson(Map<String, dynamic> json) {
    return TransportationDetails(
      localTransport: json['localTransport'],
      tips: json['tips'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'localTransport': localTransport,
      'tips': tips,
    };
  }
}

