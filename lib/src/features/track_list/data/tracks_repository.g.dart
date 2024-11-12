// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tracksListHash() => r'c485ffd1a5e589b3ec8cc4bcb5db9ded985ec853';

/// See also [tracksList].
@ProviderFor(tracksList)
final tracksListProvider = FutureProvider<List<Track>>.internal(
  tracksList,
  name: r'tracksListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tracksListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TracksListRef = FutureProviderRef<List<Track>>;
String _$mediaItemListHash() => r'063cd25775cdea7556931e8e8594e53dc2e809da';

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

/// See also [mediaItemList].
@ProviderFor(mediaItemList)
const mediaItemListProvider = MediaItemListFamily();

/// See also [mediaItemList].
class MediaItemListFamily extends Family<List<MediaItem>> {
  /// See also [mediaItemList].
  const MediaItemListFamily();

  /// See also [mediaItemList].
  MediaItemListProvider call(
    List<Track> trackList,
  ) {
    return MediaItemListProvider(
      trackList,
    );
  }

  @override
  MediaItemListProvider getProviderOverride(
    covariant MediaItemListProvider provider,
  ) {
    return call(
      provider.trackList,
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
  String? get name => r'mediaItemListProvider';
}

/// See also [mediaItemList].
class MediaItemListProvider extends AutoDisposeProvider<List<MediaItem>> {
  /// See also [mediaItemList].
  MediaItemListProvider(
    List<Track> trackList,
  ) : this._internal(
          (ref) => mediaItemList(
            ref as MediaItemListRef,
            trackList,
          ),
          from: mediaItemListProvider,
          name: r'mediaItemListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mediaItemListHash,
          dependencies: MediaItemListFamily._dependencies,
          allTransitiveDependencies:
              MediaItemListFamily._allTransitiveDependencies,
          trackList: trackList,
        );

  MediaItemListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.trackList,
  }) : super.internal();

  final List<Track> trackList;

  @override
  Override overrideWith(
    List<MediaItem> Function(MediaItemListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MediaItemListProvider._internal(
        (ref) => create(ref as MediaItemListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        trackList: trackList,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<MediaItem>> createElement() {
    return _MediaItemListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MediaItemListProvider && other.trackList == trackList;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, trackList.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MediaItemListRef on AutoDisposeProviderRef<List<MediaItem>> {
  /// The parameter `trackList` of this provider.
  List<Track> get trackList;
}

class _MediaItemListProviderElement
    extends AutoDisposeProviderElement<List<MediaItem>> with MediaItemListRef {
  _MediaItemListProviderElement(super.provider);

  @override
  List<Track> get trackList => (origin as MediaItemListProvider).trackList;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
