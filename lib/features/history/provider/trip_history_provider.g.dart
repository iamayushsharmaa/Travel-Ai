// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyTripsHash() => r'9254d5cbaa489a27186bbeb5a7e9621e3e502456';

/// See also [historyTrips].
@ProviderFor(historyTrips)
final historyTripsProvider =
    AutoDisposeStreamProvider<List<TravelDbModel>>.internal(
      historyTrips,
      name: r'historyTripsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$historyTripsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryTripsRef = AutoDisposeStreamProviderRef<List<TravelDbModel>>;
String _$tripHistoryNotifierHash() =>
    r'b82693267ab7112e89f4ec1000b9fc90e511e99e';

/// See also [TripHistoryNotifier].
@ProviderFor(TripHistoryNotifier)
final tripHistoryNotifierProvider =
    AutoDisposeNotifierProvider<TripHistoryNotifier, TripFilter>.internal(
      TripHistoryNotifier.new,
      name: r'tripHistoryNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$tripHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TripHistoryNotifier = AutoDisposeNotifier<TripFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
