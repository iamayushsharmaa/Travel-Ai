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
    print('Fetching trips for userId: $userId');
    return _trips.where('userId', isEqualTo: userId).snapshots().map((snapshot) {
      print('Snapshot received with ${snapshot.docs.length} docs');
      return snapshot.docs.map((doc) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          print('Doc data for ${doc.id}: $data');
          return TravelDbModel.fromJson(data);
        } catch (e) {
          print('Serialization error for doc ${doc.id}: $e');
          throw Exception('Failed to parse trip: $e');
        }
      }).toList();
    }).handleError((e) {
      print('Stream error: $e');
      throw e;
    });
  }

  FutureEither<TravelDbModel> getTripById(String travelId) async {
    try {
      final snapshot =
          await _trips.where('travelId', isEqualTo: travelId).get();
      if (snapshot.docs.isNotEmpty) {
        final trip = snapshot.docs.first;
        return right(
          TravelDbModel.fromJson(trip.data() as Map<String, dynamic>),
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

  Map<String, List<TravelDbModel>> categorizeTrips(
    List<TravelDbModel> trips,
    String userId,
  ) {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final previousMonth =
        now.month == 1
            ? DateTime(now.year - 1, 12)
            : DateTime(now.year, now.month - 1);

    final thisMonthTrips =
        trips.where((trip) {
          final tripMonth = DateTime(trip.startDate.year, trip.startDate.month);
          return trip.userId == userId && tripMonth == currentMonth;
        }).toList();

    final lastMonthTrips =
        trips.where((trip) {
          final tripMonth = DateTime(trip.startDate.year, trip.startDate.month);
          return trip.userId == userId && tripMonth == previousMonth;
        }).toList();

    return {'This Month': thisMonthTrips, 'Last Month': lastMonthTrips};
  }

  FutureEither<Unit> deleteTrip({
    required String userId,
    required String travelId,
  }) async {
    try {
      final doc = await _trips.doc(travelId).get();
      if (!doc.exists) {
        return Left(Failure('Trip with ID $travelId not found'));
      }
      final tripData = doc.data() as Map<String, dynamic>;
      if (tripData['userId'] != userId) {
        return Left(Failure('Unauthorized: You can only delete your own trips'));
      }

      await _trips.doc(travelId).delete();
      print('Trip $travelId deleted successfully');
      return const Right(unit);
    } on FirebaseException catch (e) {
      print('Firestore error deleting trip $travelId: ${e.code} - ${e.message}');
      return Left(Failure(e.message ?? 'Failed to delete trip'));
    } catch (e) {
      print('General error deleting trip $travelId: $e');
      return Left(Failure('Failed to delete trip: $e'));
    }
  }
}
