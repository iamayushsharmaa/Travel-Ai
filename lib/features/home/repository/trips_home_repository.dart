import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

import '../../../core/constant/firebase_constant.dart';
import '../../../core/failure.dart';
import '../../../core/type_def.dart';
import '../../addtrip/models/travel_db_model.dart';

part 'trips_home_repository.g.dart';

@riverpod
TripsHomeRepository tripsHomeRepository(TripsHomeRepositoryRef ref) {
  return TripsHomeRepository(firestore: ref.read(firebaseFirestoreProvider));
}

class TripsHomeRepository {
  final FirebaseFirestore _firestore;

  TripsHomeRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  Stream<List<TravelDbModel>> getUserTrips(String userId) {
    return _trips.where('userId', isEqualTo: userId).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map(
            (doc) => TravelDbModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  FutureEither<TravelDbModel> getTripById(String travelId) async {
    try {
      final snapshot =
          await _trips.where('travelId', isEqualTo: travelId).get();
      if (snapshot.docs.isNotEmpty) {
        final trip = snapshot.docs.first;
        return right(
          TravelDbModel.fromMap(trip.data() as Map<String, dynamic>),
        );
      } else {
        return left(Failure('Trip not found'));
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Map<String, List<TravelDbModel>> categorizeTrips(List<TravelDbModel> trips) {
    final now = DateTime.now();

    final currentMonth = DateTime(now.year, now.month);
    final previousMonth = DateTime(now.year, now.month - 1);

    final thisMonthTrips =
        trips.where((trip) {
          final tripMonth = DateTime(
            trip.startDate.year,
            trip.startDate.month,
          );
          return tripMonth == currentMonth;
        }).toList();

    final lastMonthTrips =
        trips.where((trip) {
          final tripMonth = DateTime(
            trip.startDate.year,
            trip.startDate.month,
          );
          return tripMonth == previousMonth;
        }).toList();

    return {'This Month': thisMonthTrips, 'Last Month': lastMonthTrips};
  }
}
