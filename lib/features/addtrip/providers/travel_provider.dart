import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/constant.dart';
import 'package:triptide/features/addtrip/models/TripPlanRequest.dart';
import 'package:triptide/features/addtrip/repository/travel_repository.dart';
import 'package:uuid/uuid.dart';

import '../../auth/provider/auth_providers.dart';

part 'travel_provider.g.dart';

@riverpod
class SubmitLoading extends _$SubmitLoading {
  @override
  bool build() => false;

  void setLoading(bool value) => state = value;
}

@riverpod
Future<String> generateAndStoreTrip(
  GenerateAndStoreTripRef ref,
  TripPlanRequest tripPlanRequest,
) async {
  final travelRepository = ref.read(travelRepositoryProvider);
  final userInfo = ref.read(userInfoProvider);
  if (userInfo == null) {
    throw Exception('User not logged in.');
  }
  final userId = userInfo.uid;
  final travelId = const Uuid().v4();

  final prompt = '''
You are an AI travel planner. Generate a complete, realistic trip plan as a STRICT JSON object.

CRITICAL RULES:
- Return ONLY a valid JSON object
- Do NOT include markdown, comments, or explanations
- Use EXACT field names and structure as provided
- Do NOT add, remove, or rename fields
- All coordinates must be REALISTIC latitude/longitude values

JSON STRUCTURE (must match exactly):
${Constant.jsonResponseExample}

TRIP INPUT DETAILS:
- currentLocation: ${tripPlanRequest.currentLocation}
- destination: ${tripPlanRequest.destination}
- startDate: ${tripPlanRequest.startDate.toIso8601String()}
- endDate: ${tripPlanRequest.endDate.toIso8601String()}
- tripType: ${tripPlanRequest.tripType}
- budget: ${tripPlanRequest.budget} (${tripPlanRequest.budgetType})
- interests: ${tripPlanRequest.interests.join(', ')}
- companions: ${tripPlanRequest.companions}
- accommodationType: ${tripPlanRequest.accommodationType}
- transportPreferences: ${tripPlanRequest.transportPreferences}
- pace: ${tripPlanRequest.pace}
- foodPreferences: ${tripPlanRequest.food}

DERIVED FIELD RULES:
- totalDays = number of days between startDate and endDate (inclusive)
- totalPeople = ${_getPeopleCount(tripPlanRequest.companions)}
- currentLat/currentLng = coordinates of currentLocation
- destinationLat/destinationLng = coordinates of destination
- images = 3 to 5 real, destination-relevant image URLs

CONTENT GUIDELINES:
- Daily plans must be realistic and paced according to "pace"
- Activities should align with interests
- Accommodation suggestions must match accommodationType and budget
- Transportation tips should be location-specific
- Budget should be realistic for the destination
- Avoid generic or repetitive descriptions

Return ONLY the JSON object.
''';

  final result = await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: userId,
    travelId: travelId,
  );

  return result.fold((l) {
    throw Exception(l.message);
  }, (r) => r.travelId);
}

int _getPeopleCount(String companions) {
  switch (companions.toLowerCase()) {
    case 'solo':
      return 1;
    case 'partner':
      return 2;
    case 'family':
      return 4; // Average family size
    case 'friends':
      return 3; // Average friend group
    default:
      return 1;
  }
}
