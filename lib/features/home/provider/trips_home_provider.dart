import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/home/repository/trips_home_repository.dart';

import '../../addtrip/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';

part 'trips_home_provider.g.dart';

@riverpod
Stream<List<TravelDbModel>> userTrips(UserTripsRef ref) {
  final userId = ref.read(userInfoProvider)!.uid;
  final repository = ref.read(tripsHomeRepositoryProvider);
  print('in provider');
  return repository.getUserTrips(userId);
}

@riverpod
Future<TravelDbModel> tripById(TripByIdRef ref, String travelId) async {
  final repository = ref.read(tripsHomeRepositoryProvider);
  final result = await repository.getTripById(travelId);

  return result.fold((l) => throw Exception(l.message), (trip) => trip);
}

@riverpod
Future<Map<String, List<TravelDbModel>>> categorizeTrips(
  CategorizeTripsRef ref,
) async {
  final trips = ref.watch(userTripsProvider).valueOrNull ?? [];

  final userInfo = ref.watch(userInfoProvider);
  if (userInfo == null) return {'This Month': [], 'Last Month': []};

  final userId = userInfo.uid;
  final repositroy = ref.read(tripsHomeRepositoryProvider);
  return repositroy.categorizeTrips(trips, userId);
}


@riverpod
Future<void> insertSampleTripOnStart(InsertSampleTripOnStartRef ref) async {
  final repo = ref.read(tripsHomeRepositoryProvider);
  final userId = ref.read(userInfoProvider)!.uid;

  print('userId is $userId');

  if (userId != null) {
    print('userId is userId');
    await repo.addSampleTripForUser(userId);
  }
}
