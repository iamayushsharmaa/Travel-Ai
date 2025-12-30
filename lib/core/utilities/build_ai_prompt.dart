import '../../features/addtrip/models/TripPlanRequest.dart';
import '../../shared/models/travel_db_model.dart';
import '../constant/constant.dart';

class BuildAiPrompt {
  static String buildTripGenerationPrompt({
    required TripPlanRequest request,
    required String languageCode,
  }) {
    return '''
You are an AI travel planner.

CRITICAL LANGUAGE RULE:
- Generate ALL user-facing text strictly in this language: "$languageCode"
- Do NOT mix languages
- Place names must remain original, descriptions must be translated

CRITICAL FORMAT RULES:
- Return ONLY a valid JSON object
- Do NOT include markdown
- Do NOT wrap response in ``` or ```json
- Do NOT include comments or explanations
- Use EXACT field names and structure as provided
- Do NOT add, remove, or rename fields
- All arrays must be returned (use empty arrays if no data)
- All objects must be returned (use empty values if needed)
- All coordinates must be REALISTIC latitude/longitude values

JSON STRUCTURE (must match exactly):
${Constant.jsonResponseExample}

TRIP INPUT DETAILS:
- currentLocation: ${request.currentLocation}
- destination: ${request.destination}
- startDate: ${request.startDate.toIso8601String()}
- endDate: ${request.endDate.toIso8601String()}
- tripType: ${request.tripType}
- budget: ${request.budget} (${request.budgetType})
- interests: ${request.interests.join(', ')}
- companions: ${request.companions}
- accommodationType: ${request.accommodationType}
- transportPreferences: ${request.transportPreferences}
- pace: ${request.pace}
- foodPreferences: ${request.food}

DERIVED FIELD RULES:
- totalDays = number of days between startDate and endDate (inclusive)
- totalPeople = ${_getPeopleCount(request.companions)}
- currentLat/currentLng = coordinates of currentLocation
- destinationLat/destinationLng = coordinates of destination

IMAGE RULES:
- images must be an array with 3–5 items
- Each item can be EITHER:
  - a valid public image URL
  - OR a short destination-related image search keyword
- Do NOT return fake or placeholder URLs

CONTENT GUIDELINES:
- Daily plans must be realistic and paced according to "pace"
- Activities should align with interests
- Accommodation suggestions must match accommodationType and budget
- Transportation tips must be location-specific
- Budget must be realistic for the destination
- Avoid generic or repetitive descriptions

Return ONLY the JSON object.
''';
  }

  static String buildTripRegenerationPrompt({
    required TravelDbModel trip,
    required String languageCode,
  }) {
    return '''
You are an AI travel planner.

TASK:
Regenerate the SAME trip in a different language.

CRITICAL LANGUAGE RULE:
- Rewrite ALL user-facing text strictly in "$languageCode"
- Do NOT change meaning, structure, or plan
- Do NOT invent new places, days, or activities
- Keep dates, coordinates, counts EXACTLY the same

CRITICAL FORMAT RULES:
- Return ONLY a valid JSON object
- Do NOT include markdown, comments, or explanations
- Use EXACT field names and structure
- Do NOT add, remove, or rename fields

JSON STRUCTURE (must match exactly):
${Constant.jsonResponseExample}

EXISTING TRIP DATA (REFERENCE ONLY):
${trip.toMap()}

REGENERATION RULES:
- Translate descriptions, titles, tips, and food recommendations
- Place names must remain original
- Maintain original pacing, budget, and logic

Return ONLY the JSON object.
''';
  }

  static int _getPeopleCount(String companions) {
    switch (companions.toLowerCase()) {
      case 'solo':
        return 1;
      case 'partner':
        return 2;
      case 'family':
        return 4;
      case 'friends':
        return 3;
      default:
        return 1;
    }
  }
}
