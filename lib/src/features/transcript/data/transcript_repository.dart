import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';

part 'transcript_repository.g.dart';

/// Provides a [Transcript] for a given [Track].
///
/// Transcript files must follow a specific naming pattern based on track name
/// and locale. If a track is named [001.m4a], then the English language
/// transcript must be named [001.en.json]. See the documentation of the
/// [Transcript] class for information about formatting the internal structure
/// of the files.
///
/// Returns a [Future] of type [Transcript?] via the
/// [TranscriptRepository.getTranscript] method. [null] values occur when a
/// requested file is not found. It may be the case that only some tracks do not
/// have transcripts or translations.
class TranscriptRepository {
  const TranscriptRepository();

  Future<Transcript?> getTranscript(Track track, Locale? locale) async {
    if (locale == null) {
      return null;
    }

    final jsonFilename = '${track.filenameStem}.${locale.toLanguageTag()}.json';
    final jsonUri = p.join(Config.assetsDir, jsonFilename);
    try {
      final transcriptJson = await rootBundle.loadString(jsonUri);
      return Transcript.fromJson(transcriptJson);
    } catch (error) {
      return null;
    }
  }
}

@riverpod
TranscriptRepository transcriptRepository(Ref ref) {
  return const TranscriptRepository();
}
