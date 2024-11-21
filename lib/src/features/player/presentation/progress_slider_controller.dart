import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/position_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_slider_controller.g.dart';

@riverpod
class ProgressSliderController extends _$ProgressSliderController {
  @override
  PositionData build() {
    // If the stream isn't active when the widget loads, get the most recent
    // position data from the audio handler service.
    return ref.watch(positionDataStreamProvider).when(
          loading: () =>
              ref.read(audioHandlerProvider).requireValue.lastPositionData,
          error: (_, __) =>
              ref.read(audioHandlerProvider).requireValue.lastPositionData,
          data: (positionData) => positionData,
        );
  }

  // Using this method throws the following exception:
  //
  // Cannot use ref functions after the dependency of a provider changed but
  // before the provider rebuilt, when chaining providers
  //
  // It's cause by calling ref.read on the same provider inside of this
  // notifier's build method. The Riverpod author is aware of this behavior and
  // agrees that it isn't desireable, but it hasn't been fixed as of November
  // 2024. Refer to this GitHub issue:
  //
  // https://github.com/rrousselGit/riverpod/issues/3354
  //
  // In the meantime, the onSeekProvider below gets around the problem without
  // having to access the audio handler directly in the UI code.
  //
  // void onSeek(Duration position) {
  //   ref.read(audioHandlerProvider).requireValue.seek(position);
  // }
}

@riverpod
onSeek(Ref ref, Duration position) {
  return ref.watch(audioHandlerProvider).requireValue.seek(position);
}
