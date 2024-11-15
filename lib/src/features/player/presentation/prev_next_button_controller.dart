import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prev_next_button_controller.g.dart';

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
