import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_list_controller.g.dart';

@riverpod
class TrackListController extends _$TrackListController {
  @override
  AsyncValue<int?> build() => ref.watch(queueIndexStreamProvider);
}
