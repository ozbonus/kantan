import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';

part 'transcript_repository.g.dart';

class TranscriptRepository {
  const TranscriptRepository();

  Future<Transcript?> getTranscript(Track track, Locale locale) async {
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
