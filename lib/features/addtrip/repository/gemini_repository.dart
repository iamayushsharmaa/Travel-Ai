import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/core/type_def.dart';
import 'package:triptide/features/addtrip/models/travel_db_model.dart';
import 'package:triptide/features/addtrip/repository/api_service.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

part 'gemini_repository.g.dart';

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

  CollectionReference get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  FutureEither<TravelDbModel> generateTripAndStore({
    required String prompt,
    required String userId,
    required String travelId,
  }) async {
    try {
      final tripResponse = await _apiService.getGeminiComplete(prompt);
      final storeTrip = TravelDbModel(
        travelId: travelId,
        userId: userId,
        tripPlan: tripResponse,
      );

      await _trips.doc(travelId).set(storeTrip.toMap());
      return right(storeTrip);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
