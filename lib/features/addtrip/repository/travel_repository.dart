import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/features/addtrip/mapper/travel_model_mapper.dart';
import 'package:triptide/features/addtrip/repository/api_service.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';
import 'package:triptide/shared/models/travel_db_model.dart';

part 'travel_repository.g.dart';

@riverpod
TravelRepository travelRepository(TravelRepositoryRef ref) {
  return TravelRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
    apiService: ref.watch(geminiApiServiceProvider),
  );
}

class TravelRepository {
  final FirebaseFirestore _firestore;
  final GeminiApiService _apiService;

  TravelRepository({
    required FirebaseFirestore firestore,
    required GeminiApiService apiService,
  }) : _firestore = firestore,
       _apiService = apiService;

  CollectionReference<Map<String, dynamic>> get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  Future<Either<Failure, TravelDbModel>> generateTripAndStore({
    required String prompt,
    required String userId,
    required String travelId,
    required String language,
  }) async {
    try {
      final aiTrip = await _apiService.getGeminiComplete(prompt);

      final trip = TravelDbMapper.fromGemini(
        ai: aiTrip,
        userId: userId,
        travelId: travelId,
        language: language,
      );

      await _trips.doc(travelId).set({
        ...trip.toMap(),
        'travelId': travelId,
        'userId': userId,
        'language': language,
      });

      return Right(trip);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore error'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
