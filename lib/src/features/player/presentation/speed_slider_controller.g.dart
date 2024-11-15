// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speed_slider_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$speedHash() => r'6dd5b88446e6f442a9e607265f005c5a21d6b1d3';

/// See also [speed].
@ProviderFor(speed)
final speedProvider = AutoDisposeProvider<AsyncValue<double>>.internal(
  speed,
  name: r'speedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$speedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpeedRef = AutoDisposeProviderRef<AsyncValue<double>>;
String _$setSpeedHash() => r'a192b37bfc986ec0101057bdbcd5118cfc85c62b';

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

/// See also [setSpeed].
@ProviderFor(setSpeed)
const setSpeedProvider = SetSpeedFamily();

/// See also [setSpeed].
class SetSpeedFamily extends Family<Object?> {
  /// See also [setSpeed].
  const SetSpeedFamily();

  /// See also [setSpeed].
  SetSpeedProvider call(
    double speed,
  ) {
    return SetSpeedProvider(
      speed,
    );
  }

  @override
  SetSpeedProvider getProviderOverride(
    covariant SetSpeedProvider provider,
  ) {
    return call(
      provider.speed,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'setSpeedProvider';
}

/// See also [setSpeed].
class SetSpeedProvider extends AutoDisposeProvider<Object?> {
  /// See also [setSpeed].
  SetSpeedProvider(
    double speed,
  ) : this._internal(
          (ref) => setSpeed(
            ref as SetSpeedRef,
            speed,
          ),
          from: setSpeedProvider,
          name: r'setSpeedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setSpeedHash,
          dependencies: SetSpeedFamily._dependencies,
          allTransitiveDependencies: SetSpeedFamily._allTransitiveDependencies,
          speed: speed,
        );

  SetSpeedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.speed,
  }) : super.internal();

  final double speed;

  @override
  Override overrideWith(
    Object? Function(SetSpeedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetSpeedProvider._internal(
        (ref) => create(ref as SetSpeedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        speed: speed,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _SetSpeedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetSpeedProvider && other.speed == speed;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, speed.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetSpeedRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `speed` of this provider.
  double get speed;
}

class _SetSpeedProviderElement extends AutoDisposeProviderElement<Object?>
    with SetSpeedRef {
  _SetSpeedProviderElement(super.provider);

  @override
  double get speed => (origin as SetSpeedProvider).speed;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
