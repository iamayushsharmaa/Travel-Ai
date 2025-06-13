// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userTripsHash() => r'56fe6faded226766973600374e1268f66f1ff3e3';

/// See also [userTrips].
@ProviderFor(userTrips)
final userTripsProvider =
    AutoDisposeStreamProvider<List<TravelDbModel>>.internal(
      userTrips,
      name: r'userTripsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userTripsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserTripsRef = AutoDisposeStreamProviderRef<List<TravelDbModel>>;
String _$tripByIdHash() => r'8ae5528e6c22b4f6ab9555d85519edb5bffe4e2b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tripById].
@ProviderFor(tripById)
const tripByIdProvider = TripByIdFamily();

/// See also [tripById].
class TripByIdFamily extends Family<AsyncValue<TravelDbModel>> {
  /// See also [tripById].
  const TripByIdFamily();

  /// See also [tripById].
  TripByIdProvider call(String travelId) {
    return TripByIdProvider(travelId);
  }

  @override
  TripByIdProvider getProviderOverride(covariant TripByIdProvider provider) {
    return call(provider.travelId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tripByIdProvider';
}

/// See also [tripById].
class TripByIdProvider extends AutoDisposeFutureProvider<TravelDbModel> {
  /// See also [tripById].
  TripByIdProvider(String travelId)
    : this._internal(
        (ref) => tripById(ref as TripByIdRef, travelId),
        from: tripByIdProvider,
        name: r'tripByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$tripByIdHash,
        dependencies: TripByIdFamily._dependencies,
        allTransitiveDependencies: TripByIdFamily._allTransitiveDependencies,
        travelId: travelId,
      );

  TripByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.travelId,
  }) : super.internal();

  final String travelId;

  @override
  Override overrideWith(
    FutureOr<TravelDbModel> Function(TripByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TripByIdProvider._internal(
        (ref) => create(ref as TripByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        travelId: travelId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TravelDbModel> createElement() {
    return _TripByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TripByIdProvider && other.travelId == travelId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, travelId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TripByIdRef on AutoDisposeFutureProviderRef<TravelDbModel> {
  /// The parameter `travelId` of this provider.
  String get travelId;
}

class _TripByIdProviderElement
    extends AutoDisposeFutureProviderElement<TravelDbModel>
    with TripByIdRef {
  _TripByIdProviderElement(super.provider);

  @override
  String get travelId => (origin as TripByIdProvider).travelId;
}

String _$categorizeTripsHash() => r'b11092e5ae1fbe5a3fdf2f24f53c1c52bbf655ef';

/// See also [categorizeTrips].
@ProviderFor(categorizeTrips)
final categorizeTripsProvider =
    AutoDisposeFutureProvider<Map<String, List<TravelDbModel>>>.internal(
      categorizeTrips,
      name: r'categorizeTripsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$categorizeTripsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategorizeTripsRef =
    AutoDisposeFutureProviderRef<Map<String, List<TravelDbModel>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
