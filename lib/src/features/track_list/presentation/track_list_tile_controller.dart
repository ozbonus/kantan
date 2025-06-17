import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_list_tile_controller.g.dart';

@riverpod
class TrackListTileController extends _$TrackListTileController {
  @override
  bool? build(int index) {
    return ref
        .watch(queueIndexStreamProvider)
        .whenOrNull(
          data: (queueIndex) => queueIndex == index,
        );
  }

  void skipToTrack(int index) {
    ref.read(audioHandlerProvider).requireValue.skipToQueueItem(index);
  }
}
