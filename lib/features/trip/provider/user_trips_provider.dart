import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/enums/trip_filter.dart';
import '../../../shared/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';
import '../model/month_this_count.dart';
import '../repository/user_trips_repository.dart';

part 'user_trips_provider.g.dart';

@riverpod
Stream<List<TravelDbModel>> userTrips(UserTripsRef ref) {
  final user = ref.watch(userInfoProvider);
  if (user == null) return const Stream.empty();

  final repo = ref.watch(userTripsRepositoryProvider);
  return repo.getUserTrips(user.uid);
}

@riverpod
Future<TravelDbModel> tripById(TripByIdRef ref, String travelId) async {
  final repo = ref.watch(userTripsRepositoryProvider);
  final result = await repo.getTripById(travelId);

  return result.fold((f) => throw Exception(f.message), (trip) => trip);
}


@riverpod
Future<void> deleteTrip(DeleteTripRef ref, String travelId) async {
  final repo = ref.watch(userTripsRepositoryProvider);
  await repo.deleteTrip(travelId);
}

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

      final thisMonthCount =
          trips.where((trip) {
            return trip.startDate.isAfter(thisMonthStart) ||
                trip.startDate.isAtSameMomentAs(thisMonthStart);
          }).length;

      final lastMonthCount =
          trips.where((trip) {
            return trip.startDate.isAfter(lastMonthStart) &&
                trip.startDate.isBefore(lastMonthEnd);
          }).length;

      return AsyncValue.data(
        MonthTripCount(thisMonth: thisMonthCount, lastMonth: lastMonthCount),
      );
    },
  );
}
