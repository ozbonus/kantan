import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rewind_forward_button_controller.g.dart';

@riverpod
class RewindForwardButtonController extends _$RewindForwardButtonController {
  @override
  void build() {}

  void rewind() {
    ref.read(audioHandlerProvider).requireValue.rewind();
  }

  void fastForward() {
    ref.read(audioHandlerProvider).requireValue.fastForward();
  }
}
