import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/constant.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/features/addtrip/models/TripPlanRequest.dart';
import 'package:triptide/features/addtrip/repository/gemini_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../core/type_def.dart';
import '../../auth/provider/auth_providers.dart';
import '../models/travel_db_model.dart';

part 'travel_provider.g.dart';

@riverpod
Future<Either<Failure, TravelDbModel>> generateAndStoreTrip(
    GenerateAndStoreTripRef ref,
    TripPlanRequest tripPlanRequest,
    ) async {
  final travelRepository = ref.read(travelRepositoryProvider);
  final userId = ref.read(userInfoProvider)!.uid;
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

  return await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: userId,
    travelId: travelId,
  );
}
