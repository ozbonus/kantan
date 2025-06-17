import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_screen_title_controller.g.dart';

@riverpod
String? transcriptScreenTitleController(Ref ref) {
  final trackNameValue = ref.watch(currentTrackStreamProvider);
  return trackNameValue.whenOrNull(
    data: (track) => track?.title,
  );
}
