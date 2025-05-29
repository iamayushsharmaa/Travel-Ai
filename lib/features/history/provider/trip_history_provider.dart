import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

import '../../addtrip/models/travel_db_model.dart';
import '../repository/trip_history_repository.dart';

part 'trip_history_provider.g.dart';

@riverpod
Stream<List<TravelDbModel>> userHistoryTrips(UserHistoryTripsRef ref) {
  final userId = ref.read(userInfoProvider)!.uid;
  final repository = ref.read(tripHistoryRepositoryProvider);
  return repository.getUsersPreviousTrips(userId);
}
