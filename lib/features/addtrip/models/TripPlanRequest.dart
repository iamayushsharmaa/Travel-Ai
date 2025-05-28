class TripPlanRequest {
  final String currentLocation;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String tripType;
  final double budget;
  final String budgetType;
  final List<String> interests;
  final String companions;
  final String accommodationType;
  final String transportPreferences;
  final String pace;
  final String food;

  TripPlanRequest({
    required this.currentLocation,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.tripType,
    required this.budget,
    required this.budgetType,
    required this.interests,
    required this.companions,
    required this.accommodationType,
    required this.transportPreferences,
    required this.pace,
    required this.food,
  });

  Map<String, dynamic> toMap() {
    return {
      'currentLocation': this.currentLocation,
      'destination': this.destination,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'tripType': this.tripType,
      'budget': this.budget,
      'budgetType': this.budgetType,
      'interests': this.interests,
      'companions': this.companions,
      'accommodationType': this.accommodationType,
      'transportPreferences': this.transportPreferences,
      'pace': this.pace,
      'food': this.food,
    };
  }

  factory TripPlanRequest.fromMap(Map<String, dynamic> map) {
    return TripPlanRequest(
      currentLocation: map['currentLocation'] as String,
      destination: map['destination'] as String,
      startDate: map['startDate'] as DateTime,
      endDate: map['endDate'] as DateTime,
      tripType: map['tripType'] as String,
      budget: map['budget'] as double,
      budgetType: map['budgetType'] as String,
      interests: map['interests'] as List<String>,
      companions: map['companions'] as String,
      accommodationType: map['accommodationType'] as String,
      transportPreferences: map['transportPreferences'] as String,
      pace: map['pace'] as String,
      food: map['food'] as String,
    );
  }


  @override
  String toString() {
    return 'TripPlanRequest{currentLocation: $currentLocation, destination: $destination, startDate: $startDate, endDate: $endDate, tripType: $tripType, budget: $budget, budgetType: $budgetType, interests: $interests, companions: $companions, accommodationType: $accommodationType, transportPreferences: $transportPreferences, pace: $pace, food: $food}';
  }

  TripPlanRequest copyWith({
    String? currentLocation,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    String? tripType,
    double? budget,
    String? budgetType,
    List<String>? interests,
    String? companions,
    String? accommodationType,
    String? transportPreferences,
    String? pace,
    String? food,
  }) {
    return TripPlanRequest(
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tripType: tripType ?? this.tripType,
      budget: budget ?? this.budget,
      budgetType: budgetType ?? this.budgetType,
      interests: interests ?? this.interests,
      companions: companions ?? this.companions,
      accommodationType: accommodationType ?? this.accommodationType,
      transportPreferences: transportPreferences ?? this.transportPreferences,
      pace: pace ?? this.pace,
      food: food ?? this.food,
    );
  }
}
