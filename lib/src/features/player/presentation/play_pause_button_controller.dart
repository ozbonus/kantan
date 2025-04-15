import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_pause_button_controller.g.dart';

@riverpod
class PlayPauseButtonController extends _$PlayPauseButtonController {
  @override
  KantanPlaybackState build() {
    return ref.watch(kantanPlaybackStateStreamProvider).when(
          skipLoadingOnReload: true,
          loading: () => KantanPlaybackState.loading,
          error: (_, __) => KantanPlaybackState.error,
          data: (playbackState) => playbackState,
        );
  }

  void activate() async {
    switch (state) {
      case KantanPlaybackState.loading:
      case KantanPlaybackState.error:
        return;
      case KantanPlaybackState.playing:
        ref.read(audioHandlerProvider).requireValue.pause();
      case KantanPlaybackState.paused:
        ref.read(audioHandlerProvider).requireValue.play();
      case KantanPlaybackState.completed:
        await ref.read(audioHandlerProvider).requireValue.skipToQueueItem(0);
        await Future.delayed(const Duration(milliseconds: 10));
        await ref.read(audioHandlerProvider).requireValue.play();
    }
  }
}
