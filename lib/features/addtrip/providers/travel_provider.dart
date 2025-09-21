import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/constant.dart';
import 'package:triptide/features/addtrip/models/TripPlanRequest.dart';
import 'package:triptide/features/addtrip/repository/gemini_repository.dart';
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
Future<String> generateAndStoreTrip(GenerateAndStoreTripRef ref,
    TripPlanRequest tripPlanRequest,) async {
  final travelRepository = ref.read(travelRepositoryProvider);
  final userInfo = ref.read(userInfoProvider);
  if (userInfo == null) {
    throw Exception('User not logged in.');
  }
  final userId = userInfo.uid;
  print('userId: $userId');
  final travelId = const Uuid().v4();

  final prompt = '''
You are a travel planner assistant. Based on the following trip details, generate a complete trip plan in JSON format. Return only a valid, parsable JSON object matching the following structure, without any markdown or code block wrappers:

${Constant.jsonResponseExample}

Here are the trip details:
- CurrentLocation: ${tripPlanRequest.currentLocation} (please also provide latitude and longitude)
- Destination: ${tripPlanRequest.destination} (please also provide latitude and longitude)
- Start Date: ${tripPlanRequest.startDate.toIso8601String()}
- End Date: ${tripPlanRequest.endDate.toIso8601String()}
- Trip Type: ${tripPlanRequest.tripType}
- Budget: ${tripPlanRequest.budget} (${tripPlanRequest.budgetType})
- Interests: ${tripPlanRequest.interests.join(', ')}
- Companions: ${tripPlanRequest.companions}
- Accommodation Type: ${tripPlanRequest.accommodationType}
- Transport Preferences: ${tripPlanRequest.transportPreferences}
- Pace: ${tripPlanRequest.pace}
- Food Preferences: ${tripPlanRequest.food}

Include the following additional fields in the JSON:
- tripType: String (from Trip Type)
- budget: String (from Budget)
- totalDays: int (calculated as the number of days between startDate and endDate, inclusive)
- totalPeople: int (derived from Companions)
- currentLat: double (latitude of CurrentLocation)
- currentLng: double (longitude of CurrentLocation)
- destinationLat: double (latitude of Destination)
- destinationLng: double (longitude of Destination)
- images: list of 3 to 5 URLs representing the destination (provide as "images": ["url1", "url2", "url3"])

Return only the JSON object, nothing else.
''';

  final result = await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: userId,
    travelId: travelId,
    createdAt: DateTime.now(),
  );

  return result.fold(
        (l) {
      print('Error: ${l.message}');
      throw Exception(l.message);
    },
        (r) => r.travelId,
  );
}
