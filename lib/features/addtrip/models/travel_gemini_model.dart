class TravelGeminiResponse {
  final String destination;
  final String currentLocation;
  final DateTime startDate;
  final DateTime endDate;
  final String overview;
  final String tripType;
  final int totalDays;
  final int totalPeople;
  final List<DayPlan> dailyPlan;
  final List<AccommodationSuggestion> accommodationSuggestions;
  final TransportationDetails transportationDetails;
  final List<String> foodRecommendations;
  final List<String> additionalTips;
  final String budget;

  TravelGeminiResponse({
    required this.destination,
    required this.currentLocation,
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
  });

  Map<String, dynamic> toMap() {
    return {
      'destination': this.destination,
      'currentLocation': this.currentLocation,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'overview': this.overview,
      'tripType': this.tripType,
      'totalDays': this.totalDays,
      'totalPeople': this.totalPeople,
      'dailyPlan': this.dailyPlan,
      'accommodationSuggestions': this.accommodationSuggestions,
      'transportationDetails': this.transportationDetails,
      'foodRecommendations': this.foodRecommendations,
      'additionalTips': this.additionalTips,
      'budget': this.budget,
    };
  }

  factory TravelGeminiResponse.fromMap(Map<String, dynamic> map) {
    return TravelGeminiResponse(
      destination: map['destination'] as String,
      currentLocation: map['currentLocation'] as String,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
      overview: map['overview'] as String,
      tripType: map['tripType'] as String,
      totalDays: map['totalDays'] as int,
      totalPeople: map['totalPeople'] as int,
      dailyPlan: map['dailyPlan'] as List<DayPlan>,
      accommodationSuggestions:
          map['accommodationSuggestions'] as List<AccommodationSuggestion>,
      transportationDetails:
          map['transportationDetails'] as TransportationDetails,
      foodRecommendations: map['foodRecommendations'] as List<String>,
      additionalTips: map['additionalTips'] as List<String>,
      budget: map['budget'] as String,
    );
  }
}

class DayPlan {
  final int day;
  final String date;
  final List<Activity> activities;

  DayPlan({required this.day, required this.date, required this.activities});

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json['day'],
      date: json['date'],
      activities:
          (json['activities'] as List)
              .map((e) => Activity.fromJson(e))
              .toList(),
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

  Activity({required this.time, required this.description});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(time: json['time'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'description': description};
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
  final List<String> transportModes;
  final String localTransport;
  final String tips;

  TransportationDetails({
    required this.transportModes,
    required this.localTransport,
    required this.tips,
  });

  factory TransportationDetails.fromJson(Map<String, dynamic> json) {
    return TransportationDetails(
      transportModes: json['transportModes'] ?? '',
      localTransport: json['localTransport'] ?? '',
      tips: json['tips'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transportModes': transportModes,
      'localTransport': localTransport,
      'tips': tips,
    };
  }
}
