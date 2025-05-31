import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
import 'package:triptide/core/enums/trip_filter.dart';
import 'package:triptide/features/addtrip/models/travel_db_model.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

part 'trip_history_repository.g.dart';

@riverpod
TripHistoryRepository tripHistoryRepository(TripHistoryRepositoryRef ref) {
  return TripHistoryRepository(firestore: ref.read(firebaseFirestoreProvider));
}

class TripHistoryRepository {
  final FirebaseFirestore _firestore;

  TripHistoryRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  Stream<List<TravelDbModel>> getUsersPreviousTrips({
    required String userId,
    required TripFilter filter,
  }) {
    final now = DateTime.now();
    final startOfThisMonth = DateTime(now.year, now.month, 1);
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
    final endOfLastMonth = DateTime(now.year, now.month, 0);

    Query query = _trips.where('userId', isEqualTo: userId);

    switch (filter) {
      case TripFilter.thisMonth:
        query = query
            .where(
              'endDate',
              isGreaterThanOrEqualTo: startOfThisMonth.toIso8601String(),
            )
            .where('endDate', isLessThanOrEqualTo: now.toIso8601String());
        break;
      case TripFilter.lastMonth:
        query = query
            .where(
              'endDate',
              isGreaterThanOrEqualTo: startOfLastMonth.toIso8601String(),
            )
            .where(
              'endDate',
              isLessThanOrEqualTo: endOfLastMonth.toIso8601String(),
            );
        break;
      case TripFilter.all:
        break;
      case TripFilter.favorite:
        query = query.where('isFavorite', isEqualTo: true);
        break;
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => TravelDbModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }
}
