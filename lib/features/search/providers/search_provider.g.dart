// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchTripHash() => r'9adb2b98c555363e3befbceacaf327ba9ce3cfa8';

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

/// See also [searchTrip].
@ProviderFor(searchTrip)
const searchTripProvider = SearchTripFamily();

/// See also [searchTrip].
class SearchTripFamily extends Family<AsyncValue<List<TravelDbModel>>> {
  /// See also [searchTrip].
  const SearchTripFamily();

  /// See also [searchTrip].
  SearchTripProvider call(String query) {
    return SearchTripProvider(query);
  }

  @override
  SearchTripProvider getProviderOverride(
    covariant SearchTripProvider provider,
  ) {
    return call(provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchTripProvider';
}

/// See also [searchTrip].
class SearchTripProvider
    extends AutoDisposeFutureProvider<List<TravelDbModel>> {
  /// See also [searchTrip].
  SearchTripProvider(String query)
    : this._internal(
        (ref) => searchTrip(ref as SearchTripRef, query),
        from: searchTripProvider,
        name: r'searchTripProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$searchTripHash,
        dependencies: SearchTripFamily._dependencies,
        allTransitiveDependencies: SearchTripFamily._allTransitiveDependencies,
        query: query,
      );

  SearchTripProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<TravelDbModel>> Function(SearchTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchTripProvider._internal(
        (ref) => create(ref as SearchTripRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<TravelDbModel>> createElement() {
    return _SearchTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchTripProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchTripRef on AutoDisposeFutureProviderRef<List<TravelDbModel>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchTripProviderElement
    extends AutoDisposeFutureProviderElement<List<TravelDbModel>>
    with SearchTripRef {
  _SearchTripProviderElement(super.provider);

  @override
  String get query => (origin as SearchTripProvider).query;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
