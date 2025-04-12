import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';

part 'prev_next_button_controller.g.dart';

@riverpod
void skipToPreviousButtonController(Ref ref) {
  ref.read(audioHandlerProvider).requireValue.skipToPrevious();
}

@riverpod
void skipToNextButtonController(Ref ref) {
  ref.read(audioHandlerProvider).requireValue.skipToNext();
}

@riverpod
class PrevNextButtonController extends _$PrevNextButtonController {
  @override
  void build() {}

  void skipToPrevious() {
    ref.read(audioHandlerProvider).requireValue.skipToPrevious();
  }

  void skipToNext() {
    ref.read(audioHandlerProvider).requireValue.skipToNext();
  }
}
