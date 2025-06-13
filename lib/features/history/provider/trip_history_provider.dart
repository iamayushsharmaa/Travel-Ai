import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

import '../../../core/enums/trip_filter.dart';
import '../../addtrip/models/travel_db_model.dart';
import '../repository/trip_history_repository.dart';

part 'trip_history_provider.g.dart';

@riverpod
class TripFilterNotifier extends _$TripFilterNotifier {
  @override
  TripFilter build() => TripFilter.all;

  void setFilter(TripFilter filter) {
    state = filter;
    print('Trip filter set to: ${filter.label}');
  }
}

@riverpod
Stream<List<TravelDbModel>> userHistoryTrips(UserHistoryTripsRef ref) {
  final user = ref.read(userInfoProvider);
  if (user == null) {
    print('No user logged in, returning empty stream');
    return Stream.value([]);
  }
  final userId = user.uid;
  final filter = ref.watch(tripFilterNotifierProvider);
  final repository = ref.read(tripHistoryRepositoryProvider);
  print(
    'Fetching previous trips for user $userId with filter: ${filter.label}',
  );
  return repository.getUsersPreviousTrips(userId: userId, filter: filter);
}
