// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transcriptControllerHash() =>
    r'1a3d81457f9556ed7211b97d9a363d96697de954';

/// Provides a transcript and translation for the current track, if either are
/// available.
///
/// Watches the current track stream provider and when a track is provided,
/// attempts to load transcript data from two files: one for the verbatim
/// transcript, and another for the translation.
///
/// Returns a Riverpod [AsyncValue]. If that value is [AsyncData], the data is a
/// record of two nullable [Transcript?] objects, as mentioned above. If either
/// is not available, then its associated member will be [null].
///
/// Copied from [TranscriptController].
@ProviderFor(TranscriptController)
final transcriptControllerProvider = AutoDisposeAsyncNotifierProvider<
    TranscriptController,
    ({Transcript? transcript, Transcript? translation})>.internal(
  TranscriptController.new,
  name: r'transcriptControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transcriptControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TranscriptController = AutoDisposeAsyncNotifier<
    ({Transcript? transcript, Transcript? translation})>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
