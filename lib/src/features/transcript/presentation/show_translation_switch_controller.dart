import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/transcript/application/show_translation_service.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

part 'show_translation_switch_controller.g.dart';

typedef ShowTranslationSwitchState = ({bool isActive, bool value});

/// Provides a state for the [ShowTranslationSwitch] widget in the player
/// controls of the transcript screen.
///
/// Depending on the state, the switch may be active or inactive, on or off.
///
/// Returns a [ShowTranslationSwitchState] which is a record comprising to
/// boolean values, [isActive] and [value]. [isActive] will be true if the
/// current track has a translation available. [value] corresponds to whether
/// the translation, if available, will be shown or not.
@riverpod
class ShowTranslationSwitchController
    extends _$ShowTranslationSwitchController {
  @override
  ShowTranslationSwitchState build() {
    final value = ref.watch(showTranslationServiceProvider);
    final transcriptValue = ref.watch(transcriptControllerProvider);
    return _mapTranscriptValueToState(transcriptValue, value);
  }

  ShowTranslationSwitchState _mapTranscriptValueToState(
    AsyncValue<TranscriptBundle> transcriptValue,
    bool value,
  ) {
    return transcriptValue.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      loading: () => (isActive: false, value: value),
      error: (e, st) {
        debugPrint('Error in ShowTranslationSwitchController: $e $st');
        return (isActive: false, value: false);
      },
      data: (transcript) => (
        isActive: transcript.translation != null,
        value: value,
      ),
    );
  }

  void setShowTranslation(bool value) {
    ref.read(showTranslationServiceProvider.notifier).setShowTranslation(value);
  }
}
