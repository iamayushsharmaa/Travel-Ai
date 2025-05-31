// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHistoryTripsHash() => r'4dc39f7347cdda6f5f682c158cf797920d3ea46d';

/// See also [userHistoryTrips].
@ProviderFor(userHistoryTrips)
final userHistoryTripsProvider =
    AutoDisposeStreamProvider<List<TravelDbModel>>.internal(
      userHistoryTrips,
      name: r'userHistoryTripsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userHistoryTripsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserHistoryTripsRef = AutoDisposeStreamProviderRef<List<TravelDbModel>>;
String _$tripFilterNotifierHash() =>
    r'd308fe552dc9ee3dd7be8041c421913bec4aead4';

/// See also [TripFilterNotifier].
@ProviderFor(TripFilterNotifier)
final tripFilterNotifierProvider =
    AutoDisposeNotifierProvider<TripFilterNotifier, TripFilter>.internal(
      TripFilterNotifier.new,
      name: r'tripFilterNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$tripFilterNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TripFilterNotifier = AutoDisposeNotifier<TripFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
