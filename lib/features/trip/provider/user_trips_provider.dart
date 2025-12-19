import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/enums/trip_filter.dart';
import '../../addtrip/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';
import '../repository/user_trips_repository.dart';

part 'user_trips_provider.g.dart';

@riverpod
class TripHistoryNotifier extends _$TripHistoryNotifier {
  @override
  TripFilter build() {
    return TripFilter.all;
  }

  void changeFilter(TripFilter filter) {
    state = filter;
  }
}

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
Stream<List<TravelDbModel>> userTripsByFilter(
  UserTripsByFilterRef ref, {
  required String userId,
  required TripFilter filter,
}) {
  final repo = ref.watch(userTripsRepositoryProvider);
  return repo.getUserTripsByFilter(userId: userId, filter: filter);
}

@riverpod
Future<void> deleteTrip(DeleteTripRef ref, String travelId) async {
  final repo = ref.watch(userTripsRepositoryProvider);
  await repo.deleteTrip(travelId);
}

// @riverpod
// Future<Map<String, List<TravelDbModel>>> categorizeTrips(
//   CategorizeTripsRef ref,
// ) async {
//   final trips = ref.watch(userTripsProvider).valueOrNull ?? [];
//
//   final userInfo = ref.watch(userInfoProvider);
//   if (userInfo == null) return {'This Month': [], 'Last Month': []};
//
//   final userId = userInfo.uid;
//   final repositroy = ref.read(userTripsRepositoryProvider);
//   return repositroy.categorizeTrips(trips, userId);
// }
