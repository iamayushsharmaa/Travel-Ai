class Constant {
  static const prompt = '''
You are a travel planner assistant. Based on the following trip details, generate a complete trip plan in JSON format. Only return a valid, parsable JSON object matching the following structure:
{
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
}

Here are the trip details:
- Destination: {{destination}}
- Start Date: {{startDate}}
- End Date: {{endDate}}
- Trip Type: {{tripType}}
- Budget: {{budget}} ({{budgetType}})
- Interests: {{interests}}
- Companions: {{companions}}
- Accommodation Type: {{accommodationType}}
- Transport Preferences: {{transportPreferences}}
- Pace: {{pace}}
- Food Preferences: {{food}}

Please tailor the plan to the user’s preferences and return only the JSON.
  ''';
}
