import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/transcript/application/can_see_transcript_service.dart';

part 'open_transcript_button_controller.g.dart';

@riverpod
bool showOpenTranscriptButtonController(
  Ref ref,
  bool isFullscreen,
  double screenWidth,
) {
  final canSeeTranscript = ref.watch(canSeeTranscriptServiceProvider);

  return Config.useTranscriptFeature &&
      canSeeTranscript &&
      (isFullscreen || screenWidth < Config.largeBreakpoint);
}
