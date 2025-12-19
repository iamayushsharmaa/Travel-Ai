// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_trips_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userTripsHash() => r'fa00e67bedf17ac79e3b1566cf82f750a4b06ce9';

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
String _$tripByIdHash() => r'9da27e6e8387120ee64e41ce655e1b302fe42944';

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

String _$userTripsByFilterHash() => r'd63d898b42f52a3bd2e0b049d5556a981731b3f4';

/// See also [userTripsByFilter].
@ProviderFor(userTripsByFilter)
const userTripsByFilterProvider = UserTripsByFilterFamily();

/// See also [userTripsByFilter].
class UserTripsByFilterFamily extends Family<AsyncValue<List<TravelDbModel>>> {
  /// See also [userTripsByFilter].
  const UserTripsByFilterFamily();

  /// See also [userTripsByFilter].
  UserTripsByFilterProvider call({
    required String userId,
    required TripFilter filter,
  }) {
    return UserTripsByFilterProvider(userId: userId, filter: filter);
  }

  @override
  UserTripsByFilterProvider getProviderOverride(
    covariant UserTripsByFilterProvider provider,
  ) {
    return call(userId: provider.userId, filter: provider.filter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userTripsByFilterProvider';
}

/// See also [userTripsByFilter].
class UserTripsByFilterProvider
    extends AutoDisposeStreamProvider<List<TravelDbModel>> {
  /// See also [userTripsByFilter].
  UserTripsByFilterProvider({
    required String userId,
    required TripFilter filter,
  }) : this._internal(
         (ref) => userTripsByFilter(
           ref as UserTripsByFilterRef,
           userId: userId,
           filter: filter,
         ),
         from: userTripsByFilterProvider,
         name: r'userTripsByFilterProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$userTripsByFilterHash,
         dependencies: UserTripsByFilterFamily._dependencies,
         allTransitiveDependencies:
             UserTripsByFilterFamily._allTransitiveDependencies,
         userId: userId,
         filter: filter,
       );

  UserTripsByFilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.filter,
  }) : super.internal();

  final String userId;
  final TripFilter filter;

  @override
  Override overrideWith(
    Stream<List<TravelDbModel>> Function(UserTripsByFilterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserTripsByFilterProvider._internal(
        (ref) => create(ref as UserTripsByFilterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<TravelDbModel>> createElement() {
    return _UserTripsByFilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTripsByFilterProvider &&
        other.userId == userId &&
        other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserTripsByFilterRef
    on AutoDisposeStreamProviderRef<List<TravelDbModel>> {
  /// The parameter `userId` of this provider.
  String get userId;

  /// The parameter `filter` of this provider.
  TripFilter get filter;
}

class _UserTripsByFilterProviderElement
    extends AutoDisposeStreamProviderElement<List<TravelDbModel>>
    with UserTripsByFilterRef {
  _UserTripsByFilterProviderElement(super.provider);

  @override
  String get userId => (origin as UserTripsByFilterProvider).userId;
  @override
  TripFilter get filter => (origin as UserTripsByFilterProvider).filter;
}

String _$deleteTripHash() => r'aa25643738486996ea5874ff4da602f97cd5e9bb';

/// See also [deleteTrip].
@ProviderFor(deleteTrip)
const deleteTripProvider = DeleteTripFamily();

/// See also [deleteTrip].
class DeleteTripFamily extends Family<AsyncValue<void>> {
  /// See also [deleteTrip].
  const DeleteTripFamily();

  /// See also [deleteTrip].
  DeleteTripProvider call(String travelId) {
    return DeleteTripProvider(travelId);
  }

  @override
  DeleteTripProvider getProviderOverride(
    covariant DeleteTripProvider provider,
  ) {
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
  String? get name => r'deleteTripProvider';
}

/// See also [deleteTrip].
class DeleteTripProvider extends AutoDisposeFutureProvider<void> {
  /// See also [deleteTrip].
  DeleteTripProvider(String travelId)
    : this._internal(
        (ref) => deleteTrip(ref as DeleteTripRef, travelId),
        from: deleteTripProvider,
        name: r'deleteTripProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$deleteTripHash,
        dependencies: DeleteTripFamily._dependencies,
        allTransitiveDependencies: DeleteTripFamily._allTransitiveDependencies,
        travelId: travelId,
      );

  DeleteTripProvider._internal(
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
    FutureOr<void> Function(DeleteTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteTripProvider._internal(
        (ref) => create(ref as DeleteTripRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _DeleteTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteTripProvider && other.travelId == travelId;
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
mixin DeleteTripRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `travelId` of this provider.
  String get travelId;
}

class _DeleteTripProviderElement extends AutoDisposeFutureProviderElement<void>
    with DeleteTripRef {
  _DeleteTripProviderElement(super.provider);

  @override
  String get travelId => (origin as DeleteTripProvider).travelId;
}

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
