import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/enums/trip_status.dart';
import '../../../core/utilities/build_ai_prompt.dart';
import '../../../shared/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';
import '../../settings/provider/settings_provider.dart';
import '../model/month_this_count.dart';
import '../repository/user_trips_repository.dart';

part 'user_trips_provider.g.dart';
// trip_providers.dart

@riverpod
class TripStatusNotifier extends _$TripStatusNotifier {
  @override
  void build() {}

  Future<void> markAsVisited(String travelId) async {
    final repo = ref.read(userTripsRepositoryProvider);
    await repo.updateStatus(travelId, TripStatus.visited);

    // Important: Refresh the detail page after status update
    ref.invalidate(tripByIdProvider(travelId));
  }
}

// Changed to StreamProvider (this is the biggest fix for your loading issue)
@riverpod
Stream<TravelDbModel> tripById(TripByIdRef ref, String travelId) {
  final repo = ref.watch(userTripsRepositoryProvider);

  return repo.getTripByIdStream(travelId).map((result) {
    return result.fold(
          (failure) => throw Exception(failure.message),
          (trip) => trip,
    );
  });
}

@riverpod
Future<void> regenerateTripInCurrentLanguage(
    RegenerateTripInCurrentLanguageRef ref,
    String travelId,
    ) async {
  final repo = ref.read(userTripsRepositoryProvider);        // use read here
  final locale = await ref.read(languageNotifierProvider.future);
  final languageCode = locale.languageCode;

  // Get current trip safely
  final currentTrip = await ref.read(tripByIdProvider(travelId).future);

  final prompt = BuildAiPrompt.buildTripRegenerationPrompt(
    trip: currentTrip,
    languageCode: languageCode,
  );

  await repo.replaceAiTripContent(
    travelId: travelId,
    prompt: prompt,
    language: languageCode,
  );

  // Refresh the detail view after regeneration
  ref.invalidate(tripByIdProvider(travelId));
}

@riverpod
Stream<List<TravelDbModel>> userTrips(UserTripsRef ref) {
  final user = ref.watch(userInfoProvider);
  if (user == null) return const Stream.empty();

  final repo = ref.watch(userTripsRepositoryProvider);
  return repo.getUserTrips(user.uid);
}

@riverpod
Future<void> deleteTrip(DeleteTripRef ref, String travelId) async {
  final repo = ref.read(userTripsRepositoryProvider);
  await repo.deleteTrip(travelId);

  // Optional: invalidate list if needed
  ref.invalidate(userTripsProvider);
}

// Keep this as is — it's fine
@riverpod
AsyncValue<MonthTripCount> monthTripCount(MonthTripCountRef ref) {
  final tripsAsync = ref.watch(userTripsProvider);

  return tripsAsync.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (trips) {
      final now = DateTime.now();

      final thisMonthStart = DateTime(now.year, now.month, 1);
      final lastMonthStart = DateTime(now.year, now.month - 1, 1);
      final lastMonthEnd = DateTime(now.year, now.month, 0);

      final thisMonthCount = trips.where((trip) {
        return trip.startDate.isAfter(thisMonthStart) ||
            trip.startDate.isAtSameMomentAs(thisMonthStart);
      }).length;

      final lastMonthCount = trips.where((trip) {
        return trip.startDate.isAfter(lastMonthStart) &&
            trip.startDate.isBefore(lastMonthEnd);
      }).length;

      return AsyncValue.data(
        MonthTripCount(thisMonth: thisMonthCount, lastMonth: lastMonthCount),
      );
    },
  );
}