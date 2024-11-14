import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repeat_mode_button_controller.g.dart';

@riverpod
class RepeatModeButtonController extends _$RepeatModeButtonController {
  @override
  AsyncValue<RepeatMode> build() {
    return ref.watch(repeatModeStreamProvider);
  }

  void nextRepeatMode() {
    ref.read(audioHandlerProvider).requireValue.nextRepeatMode();
  }
}
