import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/position_data.dart';

part 'debounced_position_data_stream.g.dart';

/// Returns a new value from the position data stream only if the delta from the
/// previous value is larger than the value defined in the config file. This
/// lowers the frequency of rebuilds while allowing the auto scrolling
/// transcript to appear responsive.
@riverpod
Stream<PositionData> debouncedPositionStream(Ref ref) {
  return ref
      .watch(positionDataStreamProvider.stream)
      .distinct(
        (previous, next) =>
            (previous.position - next.position).abs() <
            Config.transcriptDebounce,
      );
}
