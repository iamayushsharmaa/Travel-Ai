// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$generateAndStoreTripHash() =>
    r'4d63145c67f11893ff15a722642f73f06ee11f00';

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

/// See also [generateAndStoreTrip].
@ProviderFor(generateAndStoreTrip)
const generateAndStoreTripProvider = GenerateAndStoreTripFamily();

/// See also [generateAndStoreTrip].
class GenerateAndStoreTripFamily extends Family<AsyncValue<String>> {
  /// See also [generateAndStoreTrip].
  const GenerateAndStoreTripFamily();

  /// See also [generateAndStoreTrip].
  GenerateAndStoreTripProvider call(TripPlanRequest tripPlanRequest) {
    return GenerateAndStoreTripProvider(tripPlanRequest);
  }

  @override
  GenerateAndStoreTripProvider getProviderOverride(
    covariant GenerateAndStoreTripProvider provider,
  ) {
    return call(provider.tripPlanRequest);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generateAndStoreTripProvider';
}

/// See also [generateAndStoreTrip].
class GenerateAndStoreTripProvider extends AutoDisposeFutureProvider<String> {
  /// See also [generateAndStoreTrip].
  GenerateAndStoreTripProvider(TripPlanRequest tripPlanRequest)
    : this._internal(
        (ref) => generateAndStoreTrip(
          ref as GenerateAndStoreTripRef,
          tripPlanRequest,
        ),
        from: generateAndStoreTripProvider,
        name: r'generateAndStoreTripProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$generateAndStoreTripHash,
        dependencies: GenerateAndStoreTripFamily._dependencies,
        allTransitiveDependencies:
            GenerateAndStoreTripFamily._allTransitiveDependencies,
        tripPlanRequest: tripPlanRequest,
      );

  GenerateAndStoreTripProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripPlanRequest,
  }) : super.internal();

  final TripPlanRequest tripPlanRequest;

  @override
  Override overrideWith(
    FutureOr<String> Function(GenerateAndStoreTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GenerateAndStoreTripProvider._internal(
        (ref) => create(ref as GenerateAndStoreTripRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripPlanRequest: tripPlanRequest,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GenerateAndStoreTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GenerateAndStoreTripProvider &&
        other.tripPlanRequest == tripPlanRequest;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripPlanRequest.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GenerateAndStoreTripRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `tripPlanRequest` of this provider.
  TripPlanRequest get tripPlanRequest;
}

class _GenerateAndStoreTripProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with GenerateAndStoreTripRef {
  _GenerateAndStoreTripProviderElement(super.provider);

  @override
  TripPlanRequest get tripPlanRequest =>
      (origin as GenerateAndStoreTripProvider).tripPlanRequest;
}

String _$submitLoadingHash() => r'67fca38a8b8813fce3b95a80b78083c51563c22c';

/// See also [SubmitLoading].
@ProviderFor(SubmitLoading)
final submitLoadingProvider =
    AutoDisposeNotifierProvider<SubmitLoading, bool>.internal(
      SubmitLoading.new,
      name: r'submitLoadingProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$submitLoadingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SubmitLoading = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
