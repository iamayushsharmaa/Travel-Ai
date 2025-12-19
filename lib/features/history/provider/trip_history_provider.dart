import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:triptide/features/trip/repository/user_trips_repository.dart';

import '../../../core/enums/trip_filter.dart';
import '../../../shared/models/travel_db_model.dart';
import '../../auth/provider/auth_providers.dart';

part 'trip_history_provider.g.dart';

@riverpod
class TripHistoryNotifier extends _$TripHistoryNotifier {
  @override
  TripFilter build() {
    return TripFilter.all;
  }

  void changeFilter(TripFilter filter) {
    state = filter;
  }
}

@riverpod
Stream<List<TravelDbModel>> historyTrips(HistoryTripsRef ref) {
  final user = ref.watch(userInfoProvider);
  if (user == null) return const Stream.empty();

  final filter = ref.watch(tripHistoryNotifierProvider);
  final repo = ref.watch(userTripsRepositoryProvider);

  return repo.getUserTripsByFilter(userId: user.uid, filter: filter);
}
