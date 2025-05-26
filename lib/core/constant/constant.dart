class Constant {
  static const jsonResponseExample = ''' {
  "destination": String,
  "startDate": String (yyyy-MM-dd),
  "endDate": String (yyyy-MM-dd),
  "overview": String,
  "dailyPlan": [
    {
      "day": int,
      "date": String (yyyy-MM-dd),
      "activities": [
        {
          "time": String (e.g., "Morning", "Afternoon", "Evening"),
          "description": String
        }
      ]
    }
  ],
  "accommodationSuggestions": [
    {
      "name": String,
      "type": String,
      "location": String,
      "priceRange": String
    }
  ],
  "transportationDetails": {
    "localTransport": String,
    "tips": String
  },
  "foodRecommendations": [String],
  "additionalTips": [String]
} ''';

}

