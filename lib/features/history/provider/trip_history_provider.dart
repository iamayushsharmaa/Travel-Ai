import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';
import '../../../core/enums/trip_filter.dart';
import '../../addtrip/models/travel_db_model.dart';
import '../repository/trip_history_repository.dart';

part 'trip_history_provider.g.dart';

/// Notifier to manage the selected trip filter
@riverpod
class TripFilterNotifier extends _$TripFilterNotifier {
  @override
  TripFilter build() => TripFilter.all;

  void setFilter(TripFilter filter) {
    state = filter;
    print('[TripFilterNotifier] Filter set to: ${filter.label}');
  }
}

/// Provider to stream the user's previous trips based on selected filter
@riverpod
Stream<List<TravelDbModel>> userHistoryTrips(UserHistoryTripsRef ref) {
  final user = ref.watch(userInfoProvider);

  if (user == null) {
    print('[UserHistoryTrips] No user logged in, returning empty list');
    return Stream.value([]);
  }

  final userId = user.uid;
  final filter = ref.watch(tripFilterNotifierProvider);
  final repository = ref.read(tripHistoryRepositoryProvider);

  print('[UserHistoryTrips] Fetching trips for userId: $userId with filter: ${filter.label}');
  return repository.getUsersPreviousTrips(userId: userId, filter: filter);
}
