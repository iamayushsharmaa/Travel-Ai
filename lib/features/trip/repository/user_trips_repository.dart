import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

import '../../../core/constant/firebase_constant.dart';
import '../../../core/enums/trip_filter.dart';
import '../../../core/enums/trip_status.dart';
import '../../../core/failure.dart';
import '../../addtrip/models/travel_db_model.dart';

part 'user_trips_repository.g.dart';

@riverpod
UserTripsRepository userTripsRepository(UserTripsRepositoryRef ref) {
  return UserTripsRepository(firestore: ref.read(firebaseFirestoreProvider));
}

class UserTripsRepository {
  final FirebaseFirestore _firestore;

  UserTripsRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  Stream<List<TravelDbModel>> getUserTrips(String userId) {
    return _trips
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (s) => s.docs.map((d) => TravelDbModel.fromJson(d.data())).toList(),
        );
  }

  Stream<List<TravelDbModel>> getUserTripsByFilter({
    required String userId,
    required TripFilter filter,
  }) {
    Query<Map<String, dynamic>> query = _trips.where(
      'userId',
      isEqualTo: userId,
    );

    final now = DateTime.now();

    switch (filter) {
      case TripFilter.all:
        query = query.where('status', isEqualTo: TripStatus.visited.name);
        break;

      case TripFilter.favorite:
        query = query
            .where('status', isEqualTo: TripStatus.visited.name)
            .where('isFavorite', isEqualTo: true);
        break;

      case TripFilter.thisMonth:
        query = query
            .where('status', isEqualTo: TripStatus.visited.name)
            .where(
              'visitedAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(
                DateTime(now.year, now.month, 1),
              ),
            );
        break;

      case TripFilter.lastMonth:
        query = query
            .where('status', isEqualTo: TripStatus.visited.name)
            .where(
              'visitedAt',
              isGreaterThanOrEqualTo: Timestamp.fromDate(
                DateTime(now.year, now.month - 1, 1),
              ),
            )
            .where(
              'visitedAt',
              isLessThanOrEqualTo: Timestamp.fromDate(
                DateTime(now.year, now.month, 0),
              ),
            );
        break;
    }

    return query.snapshots().map(
      (s) => s.docs.map((d) => TravelDbModel.fromJson(d.data())).toList(),
    );
  }

  Future<Either<Failure, TravelDbModel>> getTripById(String travelId) async {
    final doc = await _trips.doc(travelId).get();
    if (!doc.exists) {
      return Left(Failure('Trip not found'));
    }
    return Right(TravelDbModel.fromJson(doc.data()!));
  }

  Future<void> deleteTrip(String travelId) {
    return _trips.doc(travelId).delete();
  }

  Future<void> updateStatus(String travelId, TripStatus status) {
    return _trips.doc(travelId).update({
      'status': status.name,
      if (status == TripStatus.visited) 'visitedAt': Timestamp.now(),
    });
  }

  Future<void> toggleFavorite(String travelId, bool isFavorite) {
    return _trips.doc(travelId).update({'isFavorite': isFavorite});
  }
}
