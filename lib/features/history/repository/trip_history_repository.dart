import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
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

  Stream<List<TravelDbModel>> getUsersPreviousTrips(String userId) {
    final now = DateTime.now();
    return _trips
        .where('endDate', isEqualTo: now.toIso8601String())
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) =>
                    TravelDbModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList();
        });
  }
}
