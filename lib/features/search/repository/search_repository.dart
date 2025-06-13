import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/core/type_def.dart';
import 'package:triptide/features/addtrip/models/travel_db_model.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

part 'search_repository.g.dart';

@riverpod
SearchRepository searchRepository(SearchRepositoryRef ref) {
  return SearchRepository(firestore: ref.read(firebaseFirestoreProvider));
}

class SearchRepository {
  final FirebaseFirestore _firestore;

  SearchRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference get _trips =>
      _firestore.collection(FirebaseConstant.trips);

  FutureEither<List<TravelDbModel>> searchTrips(String query) async {
    try {
      if (query.isEmpty) return right([]);
      final snapshot =
          await _trips
              .where('destination', isEqualTo: query)
              .where('destination', isLessThanOrEqualTo: query + '\uf8ff')
              .get();
      final trips =
          snapshot.docs
              .map(
                (doc) =>
                    TravelDbModel.fromJson(doc.data() as Map<String, dynamic>),
              )
              .toList();

      return right(trips);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
