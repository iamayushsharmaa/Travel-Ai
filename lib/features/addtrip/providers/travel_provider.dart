import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/constant.dart';
import 'package:triptide/features/addtrip/models/TripPlanRequest.dart';
import 'package:triptide/features/addtrip/models/travel_db_model.dart';
import 'package:triptide/features/addtrip/repository/gemini_repository.dart';
import 'package:uuid/uuid.dart';

import '../../auth/provider/auth_providers.dart';

part 'travel_provider.g.dart';

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
  print('userId: $userId');
  final travelId = const Uuid().v4();

  final prompt = '''
You are a travel planner assistant. Based on the following trip details, generate a complete trip plan in JSON format. Only return a valid, parsable JSON object matching the following structure:

${Constant.jsonResponseExample}
 
Here are the trip details:
- Destination: ${tripPlanRequest.destination}
- Start Date: ${tripPlanRequest.startDate}
- End Date: ${tripPlanRequest.endDate}
- Trip Type: ${tripPlanRequest.tripType}
- Budget: ${tripPlanRequest.budget} (${tripPlanRequest.budgetType})
- Interests: ${tripPlanRequest.interests.join(', ')}
- Companions: ${tripPlanRequest.companions}
- Accommodation Type: ${tripPlanRequest.accommodationType}
- Transport Preferences: ${tripPlanRequest.transportPreferences}
- Pace: ${tripPlanRequest.pace}
- Food Preferences: ${tripPlanRequest.food}

Please tailor the plan to the user’s preferences and return only the JSON.
''';

  final result = await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: userId,
    travelId: travelId,
  );

  return result.fold((l) {
    print('Eror : ${l.message}');
    throw Exception(l.message);
  }, (r) => r.travelId);
}

@riverpod
Stream<List<TravelDbModel>> userTrips(UserTripsRef ref) {
  final userId = ref.read(userInfoProvider)!.uid;
  final repository = ref.read(travelRepositoryProvider);

  return repository.getUserTrips(userId);
}

@riverpod
Future<TravelDbModel> tripById(TripByIdRef ref, String travelId) async {
  final repository = ref.read(travelRepositoryProvider);
  final result = await repository.getTripById(travelId);

  return result.fold((l) => throw Exception(l.message), (trip) => trip);
}
