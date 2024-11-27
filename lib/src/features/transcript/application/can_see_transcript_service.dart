import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'can_see_transcript_service.g.dart';

@riverpod
class CanSeeTranscriptService extends _$CanSeeTranscriptService {
  @override
  bool build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.canSeeTranscript;
    return initialState;
  }

  void setCanSeeTranscript(bool value) {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setCanSeeTranscript(value);
    state = value;
  }
}
