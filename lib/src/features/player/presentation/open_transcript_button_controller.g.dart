// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_transcript_button_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showOpenTranscriptButtonControllerHash() =>
    r'8b1de5da76270448d569fe2b1de43fcde772d64e';

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

/// See also [showOpenTranscriptButtonController].
@ProviderFor(showOpenTranscriptButtonController)
const showOpenTranscriptButtonControllerProvider =
    ShowOpenTranscriptButtonControllerFamily();

/// See also [showOpenTranscriptButtonController].
class ShowOpenTranscriptButtonControllerFamily extends Family<bool> {
  /// See also [showOpenTranscriptButtonController].
  const ShowOpenTranscriptButtonControllerFamily();

  /// See also [showOpenTranscriptButtonController].
  ShowOpenTranscriptButtonControllerProvider call(
    bool isFullscreen,
    double screenWidth,
  ) {
    return ShowOpenTranscriptButtonControllerProvider(
      isFullscreen,
      screenWidth,
    );
  }

  @override
  ShowOpenTranscriptButtonControllerProvider getProviderOverride(
    covariant ShowOpenTranscriptButtonControllerProvider provider,
  ) {
    return call(provider.isFullscreen, provider.screenWidth);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'showOpenTranscriptButtonControllerProvider';
}

/// See also [showOpenTranscriptButtonController].
class ShowOpenTranscriptButtonControllerProvider
    extends AutoDisposeProvider<bool> {
  /// See also [showOpenTranscriptButtonController].
  ShowOpenTranscriptButtonControllerProvider(
    bool isFullscreen,
    double screenWidth,
  ) : this._internal(
        (ref) => showOpenTranscriptButtonController(
          ref as ShowOpenTranscriptButtonControllerRef,
          isFullscreen,
          screenWidth,
        ),
        from: showOpenTranscriptButtonControllerProvider,
        name: r'showOpenTranscriptButtonControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$showOpenTranscriptButtonControllerHash,
        dependencies: ShowOpenTranscriptButtonControllerFamily._dependencies,
        allTransitiveDependencies:
            ShowOpenTranscriptButtonControllerFamily._allTransitiveDependencies,
        isFullscreen: isFullscreen,
        screenWidth: screenWidth,
      );

  ShowOpenTranscriptButtonControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isFullscreen,
    required this.screenWidth,
  }) : super.internal();

  final bool isFullscreen;
  final double screenWidth;

  @override
  Override overrideWith(
    bool Function(ShowOpenTranscriptButtonControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShowOpenTranscriptButtonControllerProvider._internal(
        (ref) => create(ref as ShowOpenTranscriptButtonControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isFullscreen: isFullscreen,
        screenWidth: screenWidth,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _ShowOpenTranscriptButtonControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShowOpenTranscriptButtonControllerProvider &&
        other.isFullscreen == isFullscreen &&
        other.screenWidth == screenWidth;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isFullscreen.hashCode);
    hash = _SystemHash.combine(hash, screenWidth.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShowOpenTranscriptButtonControllerRef on AutoDisposeProviderRef<bool> {
  /// The parameter `isFullscreen` of this provider.
  bool get isFullscreen;

  /// The parameter `screenWidth` of this provider.
  double get screenWidth;
}

class _ShowOpenTranscriptButtonControllerProviderElement
    extends AutoDisposeProviderElement<bool>
    with ShowOpenTranscriptButtonControllerRef {
  _ShowOpenTranscriptButtonControllerProviderElement(super.provider);

  @override
  bool get isFullscreen =>
      (origin as ShowOpenTranscriptButtonControllerProvider).isFullscreen;
  @override
  double get screenWidth =>
      (origin as ShowOpenTranscriptButtonControllerProvider).screenWidth;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
