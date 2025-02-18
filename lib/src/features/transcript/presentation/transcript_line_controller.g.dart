// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_line_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transcriptLineControllerHash() =>
    r'38b81c5d1b21ab136d93bb73fa58c61a6b6672aa';

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

/// See also [transcriptLineController].
@ProviderFor(transcriptLineController)
const transcriptLineControllerProvider = TranscriptLineControllerFamily();

/// See also [transcriptLineController].
class TranscriptLineControllerFamily extends Family<PlaybackPosition?> {
  /// See also [transcriptLineController].
  const TranscriptLineControllerFamily();

  /// See also [transcriptLineController].
  TranscriptLineControllerProvider call(
    TranscriptLine line,
    int index,
  ) {
    return TranscriptLineControllerProvider(
      line,
      index,
    );
  }

  @override
  TranscriptLineControllerProvider getProviderOverride(
    covariant TranscriptLineControllerProvider provider,
  ) {
    return call(
      provider.line,
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
  String? get name => r'transcriptLineControllerProvider';
}

/// See also [transcriptLineController].
class TranscriptLineControllerProvider
    extends AutoDisposeProvider<PlaybackPosition?> {
  /// See also [transcriptLineController].
  TranscriptLineControllerProvider(
    TranscriptLine line,
    int index,
  ) : this._internal(
          (ref) => transcriptLineController(
            ref as TranscriptLineControllerRef,
            line,
            index,
          ),
          from: transcriptLineControllerProvider,
          name: r'transcriptLineControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transcriptLineControllerHash,
          dependencies: TranscriptLineControllerFamily._dependencies,
          allTransitiveDependencies:
              TranscriptLineControllerFamily._allTransitiveDependencies,
          line: line,
          index: index,
        );

  TranscriptLineControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.line,
    required this.index,
  }) : super.internal();

  final TranscriptLine line;
  final int index;

  @override
  Override overrideWith(
    PlaybackPosition? Function(TranscriptLineControllerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TranscriptLineControllerProvider._internal(
        (ref) => create(ref as TranscriptLineControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        line: line,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<PlaybackPosition?> createElement() {
    return _TranscriptLineControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TranscriptLineControllerProvider &&
        other.line == line &&
        other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, line.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TranscriptLineControllerRef on AutoDisposeProviderRef<PlaybackPosition?> {
  /// The parameter `line` of this provider.
  TranscriptLine get line;

  /// The parameter `index` of this provider.
  int get index;
}

class _TranscriptLineControllerProviderElement
    extends AutoDisposeProviderElement<PlaybackPosition?>
    with TranscriptLineControllerRef {
  _TranscriptLineControllerProviderElement(super.provider);

  @override
  TranscriptLine get line => (origin as TranscriptLineControllerProvider).line;
  @override
  int get index => (origin as TranscriptLineControllerProvider).index;
}

String _$seekToLineHash() => r'22021ce8e6433848cd1b59dc175aef315c6d0894';

/// See also [seekToLine].
@ProviderFor(seekToLine)
const seekToLineProvider = SeekToLineFamily();

/// See also [seekToLine].
class SeekToLineFamily extends Family<Object?> {
  /// See also [seekToLine].
  const SeekToLineFamily();

  /// See also [seekToLine].
  SeekToLineProvider call(
    TranscriptLine line,
  ) {
    return SeekToLineProvider(
      line,
    );
  }

  @override
  SeekToLineProvider getProviderOverride(
    covariant SeekToLineProvider provider,
  ) {
    return call(
      provider.line,
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
  String? get name => r'seekToLineProvider';
}

/// See also [seekToLine].
class SeekToLineProvider extends AutoDisposeProvider<Object?> {
  /// See also [seekToLine].
  SeekToLineProvider(
    TranscriptLine line,
  ) : this._internal(
          (ref) => seekToLine(
            ref as SeekToLineRef,
            line,
          ),
          from: seekToLineProvider,
          name: r'seekToLineProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$seekToLineHash,
          dependencies: SeekToLineFamily._dependencies,
          allTransitiveDependencies:
              SeekToLineFamily._allTransitiveDependencies,
          line: line,
        );

  SeekToLineProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.line,
  }) : super.internal();

  final TranscriptLine line;

  @override
  Override overrideWith(
    Object? Function(SeekToLineRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SeekToLineProvider._internal(
        (ref) => create(ref as SeekToLineRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        line: line,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _SeekToLineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeekToLineProvider && other.line == line;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, line.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SeekToLineRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `line` of this provider.
  TranscriptLine get line;
}

class _SeekToLineProviderElement extends AutoDisposeProviderElement<Object?>
    with SeekToLineRef {
  _SeekToLineProviderElement(super.provider);

  @override
  TranscriptLine get line => (origin as SeekToLineProvider).line;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
