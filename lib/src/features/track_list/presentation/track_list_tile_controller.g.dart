// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_list_tile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trackListTileControllerHash() =>
    r'd8a19d019594d1664a1e3484c2ae3a570a73969b';

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

abstract class _$TrackListTileController
    extends BuildlessAutoDisposeNotifier<bool?> {
  late final int index;

  bool? build(
    int index,
  );
}

/// See also [TrackListTileController].
@ProviderFor(TrackListTileController)
const trackListTileControllerProvider = TrackListTileControllerFamily();

/// See also [TrackListTileController].
class TrackListTileControllerFamily extends Family<bool?> {
  /// See also [TrackListTileController].
  const TrackListTileControllerFamily();

  /// See also [TrackListTileController].
  TrackListTileControllerProvider call(
    int index,
  ) {
    return TrackListTileControllerProvider(
      index,
    );
  }

  @override
  TrackListTileControllerProvider getProviderOverride(
    covariant TrackListTileControllerProvider provider,
  ) {
    return call(
      provider.index,
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
  String? get name => r'trackListTileControllerProvider';
}

/// See also [TrackListTileController].
class TrackListTileControllerProvider
    extends AutoDisposeNotifierProviderImpl<TrackListTileController, bool?> {
  /// See also [TrackListTileController].
  TrackListTileControllerProvider(
    int index,
  ) : this._internal(
          () => TrackListTileController()..index = index,
          from: trackListTileControllerProvider,
          name: r'trackListTileControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trackListTileControllerHash,
          dependencies: TrackListTileControllerFamily._dependencies,
          allTransitiveDependencies:
              TrackListTileControllerFamily._allTransitiveDependencies,
          index: index,
        );

  TrackListTileControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
  }) : super.internal();

  final int index;

  @override
  bool? runNotifierBuild(
    covariant TrackListTileController notifier,
  ) {
    return notifier.build(
      index,
    );
  }

  @override
  Override overrideWith(TrackListTileController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TrackListTileControllerProvider._internal(
        () => create()..index = index,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TrackListTileController, bool?>
      createElement() {
    return _TrackListTileControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackListTileControllerProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TrackListTileControllerRef on AutoDisposeNotifierProviderRef<bool?> {
  /// The parameter `index` of this provider.
  int get index;
}

class _TrackListTileControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TrackListTileController, bool?>
    with TrackListTileControllerRef {
  _TrackListTileControllerProviderElement(super.provider);

  @override
  int get index => (origin as TrackListTileControllerProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
