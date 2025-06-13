// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHistoryTripsHash() => r'cc4e59d6159abe34270f40ef35f648deb033c216';

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
    r'c4c768e5643e7af4d31a3111e8e24646793f84ab';

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
