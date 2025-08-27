// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'c62213bddb9aac89c0a19fe034ef243e2a285ba8';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = AutoDisposeProvider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = AutoDisposeProviderRef<Dio>;
String _$weatherApiServiceHash() => r'77b690a54da373ec4c339335281e1af76519a09f';

/// See also [weatherApiService].
@ProviderFor(weatherApiService)
final weatherApiServiceProvider =
    AutoDisposeProvider<WeatherApiService>.internal(
      weatherApiService,
      name: r'weatherApiServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$weatherApiServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherApiServiceRef = AutoDisposeProviderRef<WeatherApiService>;
String _$weatherRepositoryHash() => r'fda674c3d4cfc1df6573730bdf6e2756227d3c0e';

/// See also [weatherRepository].
@ProviderFor(weatherRepository)
final weatherRepositoryProvider =
    AutoDisposeProvider<WeatherRepository>.internal(
      weatherRepository,
      name: r'weatherRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$weatherRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherRepositoryRef = AutoDisposeProviderRef<WeatherRepository>;
String _$weatherForecastHash() => r'f2a28118d33825a2e2ae7555c151a259336feedf';

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

/// See also [weatherForecast].
@ProviderFor(weatherForecast)
const weatherForecastProvider = WeatherForecastFamily();

/// See also [weatherForecast].
class WeatherForecastFamily extends Family<AsyncValue<List<WeatherEntity>>> {
  /// See also [weatherForecast].
  const WeatherForecastFamily();

  /// See also [weatherForecast].
  WeatherForecastProvider call(double lat, double lon) {
    return WeatherForecastProvider(lat, lon);
  }

  @override
  WeatherForecastProvider getProviderOverride(
    covariant WeatherForecastProvider provider,
  ) {
    return call(provider.lat, provider.lon);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weatherForecastProvider';
}

/// See also [weatherForecast].
class WeatherForecastProvider
    extends AutoDisposeFutureProvider<List<WeatherEntity>> {
  /// See also [weatherForecast].
  WeatherForecastProvider(double lat, double lon)
    : this._internal(
        (ref) => weatherForecast(ref as WeatherForecastRef, lat, lon),
        from: weatherForecastProvider,
        name: r'weatherForecastProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$weatherForecastHash,
        dependencies: WeatherForecastFamily._dependencies,
        allTransitiveDependencies:
            WeatherForecastFamily._allTransitiveDependencies,
        lat: lat,
        lon: lon,
      );

  WeatherForecastProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat,
    required this.lon,
  }) : super.internal();

  final double lat;
  final double lon;

  @override
  Override overrideWith(
    FutureOr<List<WeatherEntity>> Function(WeatherForecastRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WeatherForecastProvider._internal(
        (ref) => create(ref as WeatherForecastRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat: lat,
        lon: lon,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WeatherEntity>> createElement() {
    return _WeatherForecastProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherForecastProvider &&
        other.lat == lat &&
        other.lon == lon;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat.hashCode);
    hash = _SystemHash.combine(hash, lon.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WeatherForecastRef on AutoDisposeFutureProviderRef<List<WeatherEntity>> {
  /// The parameter `lat` of this provider.
  double get lat;

  /// The parameter `lon` of this provider.
  double get lon;
}

class _WeatherForecastProviderElement
    extends AutoDisposeFutureProviderElement<List<WeatherEntity>>
    with WeatherForecastRef {
  _WeatherForecastProviderElement(super.provider);

  @override
  double get lat => (origin as WeatherForecastProvider).lat;
  @override
  double get lon => (origin as WeatherForecastProvider).lon;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
