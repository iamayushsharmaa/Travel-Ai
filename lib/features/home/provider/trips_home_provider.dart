import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/home/repository/trips_home_repository.dart';

import '../../../core/failure.dart';
import '../../addtrip/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';

part 'trips_home_provider.g.dart';

@riverpod
Stream<List<TravelDbModel>> userTrips(UserTripsRef ref) {
  final user = ref.watch(userInfoProvider);
  if (user == null) {
    print('No user logged in, returning empty stream');
    return const Stream.empty();
  }
  print('Fetching trips for user: ${user.uid}');
  final repository = ref.read(tripsHomeRepositoryProvider);
  return repository
      .getUserTrips(user.uid)
      .handleError((e, stack) {
        print('Error in getUserTrips: $e\nStack: $stack');
        throw e; // Rethrow to ensure the error reaches the UI
      })
      .asBroadcastStream()
      .map((trips) {
        print('Stream emitted ${trips.length} trips');
        return trips;
      });
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
Future<Either<Failure, Unit>> deleteTrip(
    DeleteTripRef ref,
    String travelId,
    ) async {
  final user = ref.read(userInfoProvider);
  if (user == null) {
    print('No user logged in, cannot delete trip $travelId');
    return Left(Failure('User not logged in'));
  }
  final repository = ref.read(tripsHomeRepositoryProvider);
  print('Deleting trip $travelId for user ${user.uid}');
  return await repository.deleteTrip(
    travelId: travelId,
    userId: user.uid,
  );
}