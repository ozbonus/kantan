import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';

part 'transcript_scale_service.g.dart';

@riverpod
class TranscriptScaleService extends _$TranscriptScaleService {
  @override
  double build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.transcriptScale;
    return initialState;
  }

  void setTranscriptScale(double value) {
    ref.read(settingsRepositoryProvider).requireValue.setTranscriptScale(value);
    state = value;
  }
}
