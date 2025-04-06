import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/transcript/application/enable_auto_scroll_service.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_controller.dart';

part 'enable_auto_scroll_switch_controller.g.dart';

typedef EnableAutoScrollSwitchState = ({bool isActive, bool value});

/// Provides a state for the [EnableAutoScrollSwitch] widget in the player
/// controls of the transcript screen.
///
/// Depending on the state, the switch may be active or inactive, on or off.
///
/// Returns a [EnableAutoScrollSwitchState] which is a record comprising two
/// boolean values, [isActive] and [value]. [isActive] will be true if the
/// current track has timestamps available. [value] corresponds to whether
/// auto scroll is enabled or not.
@riverpod
class EnableAutoScrollSwitchController
    extends _$EnableAutoScrollSwitchController {
  @override
  EnableAutoScrollSwitchState build() {
    final value = ref.watch(enableAutoScrollServiceProvider);
    final transcriptValue = ref.watch(transcriptControllerProvider);
    return _mapTranscriptValueToState(transcriptValue, value);
  }

  EnableAutoScrollSwitchState _mapTranscriptValueToState(
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
        isActive: transcript.transcript?.endTimes != null,
        value: value,
      ),
    );
  }

  void setEnableAutoScroll(bool value) {
    ref
        .read(enableAutoScrollServiceProvider.notifier)
        .setEnableAutoScroll(value);
  }
}
