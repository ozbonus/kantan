// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_slider_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$onSeekHash() => r'a3a4adc8aafc19b84086940cdbfbdf5d7bb0135e';

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

/// See also [onSeek].
@ProviderFor(onSeek)
const onSeekProvider = OnSeekFamily();

/// See also [onSeek].
class OnSeekFamily extends Family<Object?> {
  /// See also [onSeek].
  const OnSeekFamily();

  /// See also [onSeek].
  OnSeekProvider call(Duration position) {
    return OnSeekProvider(position);
  }

  @override
  OnSeekProvider getProviderOverride(covariant OnSeekProvider provider) {
    return call(provider.position);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'onSeekProvider';
}

/// See also [onSeek].
class OnSeekProvider extends AutoDisposeProvider<Object?> {
  /// See also [onSeek].
  OnSeekProvider(Duration position)
    : this._internal(
        (ref) => onSeek(ref as OnSeekRef, position),
        from: onSeekProvider,
        name: r'onSeekProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$onSeekHash,
        dependencies: OnSeekFamily._dependencies,
        allTransitiveDependencies: OnSeekFamily._allTransitiveDependencies,
        position: position,
      );

  OnSeekProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.position,
  }) : super.internal();

  final Duration position;

  @override
  Override overrideWith(Object? Function(OnSeekRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: OnSeekProvider._internal(
        (ref) => create(ref as OnSeekRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        position: position,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _OnSeekProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OnSeekProvider && other.position == position;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, position.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OnSeekRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `position` of this provider.
  Duration get position;
}

class _OnSeekProviderElement extends AutoDisposeProviderElement<Object?>
    with OnSeekRef {
  _OnSeekProviderElement(super.provider);

  @override
  Duration get position => (origin as OnSeekProvider).position;
}

String _$progressSliderControllerHash() =>
    r'1e4d5cbd7e05adf7ce25cbc49d1a6e285df2a8db';

/// See also [ProgressSliderController].
@ProviderFor(ProgressSliderController)
final progressSliderControllerProvider =
    AutoDisposeNotifierProvider<
      ProgressSliderController,
      PositionData
    >.internal(
      ProgressSliderController.new,
      name: r'progressSliderControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$progressSliderControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ProgressSliderController = AutoDisposeNotifier<PositionData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
