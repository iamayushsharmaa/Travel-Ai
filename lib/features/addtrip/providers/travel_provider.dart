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
  final travelRepository = ref.watch(travelRepositoryProvider);
  final prompt = '''
You are a travel planner assistant. Based on the following trip details, generate a complete trip plan in JSON format. Only return a valid, parsable JSON object matching the following structure:

${Constant.jsonResponseExample}
 
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

  final result = await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: ref.read(userInfoProvider)!.uid,
    travelId: Uuid().v4(),
  );

  return result;
}
