import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/core/constant/firebase_constant.dart';
import 'package:triptide/core/failure.dart';
import 'package:triptide/core/type_def.dart';
import 'package:triptide/shared/models/travel_db_model.dart';
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

  FutureEither<List<TravelDbModel>> searchTrips({
    required String userId,
    required String query,
  }) async {
    try {
      final trimmedQuery = query.trim();
      print('Raw query: "$query", Trimmed query: "$trimmedQuery", User ID: $userId');
      if (trimmedQuery.isEmpty) {
        print('Empty query for user $userId, returning empty list');
        return right([]);
      }

      final normalizedQuery = trimmedQuery.toLowerCase();
      print('Normalized query: "$normalizedQuery"');

      final snapshot = await _trips
          .where('userId', isEqualTo: userId)
          .where('destinationLowerCase', isGreaterThanOrEqualTo: normalizedQuery)
          .where('destinationLowerCase', isLessThanOrEqualTo: normalizedQuery + '\uf8ff')
          .limit(20)
          .get();

      print('Snapshot docs: ${snapshot.docs.length}');
      final trips = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print('Doc ${doc.id} data: $data');
        try {
          return TravelDbModel.fromJson(data);
        } catch (e) {
          print('Error parsing document ${doc.id} for user $userId: $e');
          throw Exception('Failed to parse trip: $e');
        }
      }).toList();

      print('Found ${trips.length} trips for user $userId with query: $trimmedQuery');
      return right(trips);
    } on FirebaseException catch (e) {
      print('Firestore error searching trips for user $userId: ${e.code} - ${e.message}');
      return left(Failure(e.message ?? 'Failed to search trips'));
    } catch (e, stack) {
      print('General error searching trips for user $userId: $e\nStack: $stack');
      return left(Failure('Failed to search trips: $e'));
    }
  }
}
