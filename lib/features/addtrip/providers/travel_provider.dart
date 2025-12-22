import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/utilities/build_ai_prompt.dart';
import 'package:triptide/features/addtrip/models/TripPlanRequest.dart';
import 'package:triptide/features/addtrip/repository/travel_repository.dart';
import 'package:uuid/uuid.dart';

import '../../auth/provider/auth_providers.dart';
import '../../settings/provider/settings_provider.dart';

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
  final locale = await ref.read(languageNotifierProvider.future);
  final languageCode = locale.languageCode;

  if (userInfo == null) {
    throw Exception('User not logged in.');
  }

  final userId = userInfo.uid;
  final travelId = const Uuid().v4();

  final prompt = BuildAiPrompt.buildTripGenerationPrompt(
    request: tripPlanRequest,
    languageCode: languageCode,
  );

  final result = await travelRepository.generateTripAndStore(
    prompt: prompt,
    userId: userId,
    travelId: travelId,
    language: languageCode,
  );

  return result.fold((l) => throw Exception(l.message), (r) => r.travelId);
}
