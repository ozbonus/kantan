import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_pause_button_controller.g.dart';

@riverpod
class PlayPauseButtonController extends _$PlayPauseButtonController {
  @override
  AsyncValue<KantanPlaybackState> build() {
    state = const AsyncValue.loading();
    return ref.watch(kantanPlaybackStateStreamProvider);
  }

  void activate() {
    state.when(
      loading: () {},
      error: (e, st) => throw Exception('PlayPauseButtonController $e $st'),
      data: (data) {
        switch (data) {
          case KantanPlaybackState.loading:
          case KantanPlaybackState.error:
            () {};
          case KantanPlaybackState.playing:
            ref.read(audioHandlerProvider).requireValue.pause();
          case KantanPlaybackState.paused:
            ref.read(audioHandlerProvider).requireValue.play();
          case KantanPlaybackState.completed:
            ref.read(audioHandlerProvider).requireValue.skipToQueueItem(0);
            ref.read(audioHandlerProvider).requireValue.play();
        }
      },
    );
  }
}
