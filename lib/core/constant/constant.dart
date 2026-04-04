import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static final API_KEY = dotenv.env['GEMINI_API_KEY'] ?? '';
  static final BASE_URL = dotenv.env['BASE_URL'] ?? '';
  static final MODEL = dotenv.env['MODEL'] ?? '';


  static const jsonResponseExample = '''{
    "destination": "string",
    "currentLocation": "string",
    "currentLat": 0.0,
    "currentLng": 0.0,
    "destinationLat": 0.0,
    "destinationLng": 0.0,
    "startDate": "string",
    "endDate": "string",
    "overview": "string",
    "tripType": "string",
    "totalDays": 0,
    "totalPeople": 0,
    "images": [
      "string", 
      "string", 
      "string"
    ],
    "dailyPlan": [
      {
        "day": 0,
        "date": "string",
        "activities": [
          {
            "time": "string",
            "description": "string"
          }
        ]
      }
    ],
    "accommodationSuggestions": [
      {
        "name": "string",
        "type": "string",
        "location": "string",
        "priceRange": "string"
      }
    ],
    "transportationDetails": {
      "localTransport": "string",
      "tips": "string"
    },
    "foodRecommendations": ["string"],
    "additionalTips": ["string"],
    "budget": "string"
  }''';
}
