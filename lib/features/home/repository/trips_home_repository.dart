import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/firebase_constant.dart';
import '../../../core/failure.dart';
import '../../../core/type_def.dart';
import '../../addtrip/models/travel_db_model.dart';
import '../../addtrip/models/travel_gemini_model.dart';

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

  Map<String, List<TravelDbModel>> categorizeTrips(
    List<TravelDbModel> trips,
    String userId,
  ) {
    final userTrips = trips.where((trip) => trip.userId == userId).toList();

    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final previousMonth = DateTime(now.year, now.month - 1);

    final thisMonthTrips =
        userTrips.where((trip) {
          final tripMonth = DateTime(trip.startDate.year, trip.startDate.month);
          return tripMonth == currentMonth;
        }).toList();

    final lastMonthTrips =
        userTrips.where((trip) {
          final tripMonth = DateTime(trip.startDate.year, trip.startDate.month);
          return tripMonth == previousMonth;
        }).toList();

    return {'This Month': thisMonthTrips, 'Last Month': lastMonthTrips};
  }

  Future<void> addSampleTripForUser(String userId) async {
    if (userId.isEmpty) return;

    final trip = TravelDbModel(
      travelId: Uuid().v4(),
      userId: userId,
      createdAt: DateTime.now(),
      destination: "Goa",
      currentLocation: "Mumbai",
      tripType: "Leisure",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: 5)),
      totalDays: 5,
      totalPeople: 3,
      overview: "Fun trip to Goa",
      budget: "₹25,000",
      isFavorite: false,
      foodRecommendations: ["Fish Curry", "Bebinca"],
      additionalTips: ["Pack light", "Carry sunscreen"],
      transportationDetails: TransportationDetails(
        transportModes: ["Train", "Taxi"],
        localTransport: "Scooters",
        tips: "Rent early to avoid surge",
      ),
      accommodationSuggestions: [
        AccommodationSuggestion(
          name: "Goa Beach Resort",
          type: "Hotel",
          location: "Calangute",
          priceRange: "₹2000-3000",
        ),
      ],
      dailyPlan: [
        DayPlan(
          day: 1,
          date: DateTime.now().toIso8601String(),
          activities: [
            Activity(time: "10:00 AM", description: "Reach hotel"),
            Activity(time: "12:00 PM", description: "Beach walk"),
          ],
        ),
      ],
    );

    await _trips.doc(trip.travelId).set(trip.toMap());
  }
}
