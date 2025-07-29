// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_index_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transcriptIndexControllerHash() =>
    r'59f711e3652cc1a90f592cf1b0c682999c9b5ba5';

/// Provides the index of the transcript line presently being spoken.
///
/// Returns an [int] index when a transcript and position data stream are
/// available.
///
/// Returns [null] under the following conditions:
/// * during [AsyncLoading] and [AsyncError]
/// * [Transcript.transcript] is null
/// * [Transcript.transcript.endTimes] is null
/// * the index is out of bounds of the transcript (possible when seeking)
///
/// Copied from [transcriptIndexController].
@ProviderFor(transcriptIndexController)
final transcriptIndexControllerProvider = AutoDisposeProvider<int?>.internal(
  transcriptIndexController,
  name: r'transcriptIndexControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transcriptIndexControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TranscriptIndexControllerRef = AutoDisposeProviderRef<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
