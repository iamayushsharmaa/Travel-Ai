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

    // Base query: trips for user with endDate before now
    Query query = _trips
        .where('userId', isEqualTo: userId)
        .where('endDate', isLessThan: Timestamp.fromDate(now));

    switch (filter) {
      case TripFilter.all:
      // No additional filters, already limited to past trips
        break;
      case TripFilter.favorite:
        query = query.where('isFavorite', isEqualTo: true);
        break;
      case TripFilter.thisMonth:
        query = query
            .where('endDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfThisMonth))
            .where('endDate', isLessThanOrEqualTo: Timestamp.fromDate(now));
        break;
      case TripFilter.lastMonth:
        query = query
            .where('endDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfLastMonth))
            .where('endDate', isLessThanOrEqualTo: Timestamp.fromDate(endOfLastMonth));
        break;
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          return TravelDbModel.fromJson(doc.data() as Map<String, dynamic>);
        } catch (e) {
          print('Error parsing document ${doc.id} for user $userId: $e');
          rethrow;
        }
      }).toList();
    });
  }
}
