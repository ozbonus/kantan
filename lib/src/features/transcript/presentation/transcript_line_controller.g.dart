// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_line_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transcriptLineControllerHash() =>
    r'44bbcca2a15732d46a52fbaf85dd0721327347b9';

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

abstract class _$TranscriptLineController
    extends BuildlessAutoDisposeNotifier<TranscriptLineState> {
  late final int index;
  late final ({
    String? speaker,
    Duration? startTime,
    String text
  }) transcriptLine;
  late final ({
    String? speaker,
    Duration? startTime,
    String text
  })? translationLine;

  TranscriptLineState build(
    int index,
    ({String? speaker, Duration? startTime, String text}) transcriptLine,
    ({String? speaker, Duration? startTime, String text})? translationLine,
  );
}

/// See also [TranscriptLineController].
@ProviderFor(TranscriptLineController)
const transcriptLineControllerProvider = TranscriptLineControllerFamily();

/// See also [TranscriptLineController].
class TranscriptLineControllerFamily extends Family<TranscriptLineState> {
  /// See also [TranscriptLineController].
  const TranscriptLineControllerFamily();

  /// See also [TranscriptLineController].
  TranscriptLineControllerProvider call(
    int index,
    ({String? speaker, Duration? startTime, String text}) transcriptLine,
    ({String? speaker, Duration? startTime, String text})? translationLine,
  ) {
    return TranscriptLineControllerProvider(
      index,
      transcriptLine,
      translationLine,
    );
  }

  @override
  TranscriptLineControllerProvider getProviderOverride(
    covariant TranscriptLineControllerProvider provider,
  ) {
    return call(
      provider.index,
      provider.transcriptLine,
      provider.translationLine,
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

/// See also [TranscriptLineController].
class TranscriptLineControllerProvider extends AutoDisposeNotifierProviderImpl<
    TranscriptLineController, TranscriptLineState> {
  /// See also [TranscriptLineController].
  TranscriptLineControllerProvider(
    int index,
    ({String? speaker, Duration? startTime, String text}) transcriptLine,
    ({String? speaker, Duration? startTime, String text})? translationLine,
  ) : this._internal(
          () => TranscriptLineController()
            ..index = index
            ..transcriptLine = transcriptLine
            ..translationLine = translationLine,
          from: transcriptLineControllerProvider,
          name: r'transcriptLineControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transcriptLineControllerHash,
          dependencies: TranscriptLineControllerFamily._dependencies,
          allTransitiveDependencies:
              TranscriptLineControllerFamily._allTransitiveDependencies,
          index: index,
          transcriptLine: transcriptLine,
          translationLine: translationLine,
        );

  TranscriptLineControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
    required this.transcriptLine,
    required this.translationLine,
  }) : super.internal();

  final int index;
  final ({String? speaker, Duration? startTime, String text}) transcriptLine;
  final ({String? speaker, Duration? startTime, String text})? translationLine;

  @override
  TranscriptLineState runNotifierBuild(
    covariant TranscriptLineController notifier,
  ) {
    return notifier.build(
      index,
      transcriptLine,
      translationLine,
    );
  }

  @override
  Override overrideWith(TranscriptLineController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TranscriptLineControllerProvider._internal(
        () => create()
          ..index = index
          ..transcriptLine = transcriptLine
          ..translationLine = translationLine,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
        transcriptLine: transcriptLine,
        translationLine: translationLine,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TranscriptLineController,
      TranscriptLineState> createElement() {
    return _TranscriptLineControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TranscriptLineControllerProvider &&
        other.index == index &&
        other.transcriptLine == transcriptLine &&
        other.translationLine == translationLine;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);
    hash = _SystemHash.combine(hash, transcriptLine.hashCode);
    hash = _SystemHash.combine(hash, translationLine.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TranscriptLineControllerRef
    on AutoDisposeNotifierProviderRef<TranscriptLineState> {
  /// The parameter `index` of this provider.
  int get index;

  /// The parameter `transcriptLine` of this provider.
  ({String? speaker, Duration? startTime, String text}) get transcriptLine;

  /// The parameter `translationLine` of this provider.
  ({String? speaker, Duration? startTime, String text})? get translationLine;
}

class _TranscriptLineControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TranscriptLineController,
        TranscriptLineState> with TranscriptLineControllerRef {
  _TranscriptLineControllerProviderElement(super.provider);

  @override
  int get index => (origin as TranscriptLineControllerProvider).index;
  @override
  ({String? speaker, Duration? startTime, String text}) get transcriptLine =>
      (origin as TranscriptLineControllerProvider).transcriptLine;
  @override
  ({String? speaker, Duration? startTime, String text})? get translationLine =>
      (origin as TranscriptLineControllerProvider).translationLine;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
