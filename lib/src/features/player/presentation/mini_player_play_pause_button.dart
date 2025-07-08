import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/presentation/play_pause_button_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

/// In this version of Kantan Player all of the audio files are stored on device
/// which means that loading is nearly instantaneous. However, when skipping
/// tracks the app does very briefly pass through a loading state. Because this
/// loading state is so brief, it's not helpful to communicate to the user. The
/// design of this `StatefulWidget` prevents the icon from ever showing the
/// loading state. In a future version of Kantan Player which can load audio
/// over the web, showing the loading state can be re-enabled.
class MiniPlayerPlayPauseButton extends ConsumerStatefulWidget {
  const MiniPlayerPlayPauseButton({super.key});

  @override
  ConsumerState<MiniPlayerPlayPauseButton> createState() =>
      _MiniPlayerPlayPauseButtonState();
}

class _MiniPlayerPlayPauseButtonState
    extends ConsumerState<MiniPlayerPlayPauseButton> {
  late KantanPlaybackState playbackState;

  @override
  void initState() {
    super.initState();
    final initState = ref.read(playPauseButtonControllerProvider);
    setState(() => playbackState = initState);
  }

  @override
  void dispose() => super.dispose();

  void resolveState(KantanPlaybackState state) {
    if (state == KantanPlaybackState.loading) {
      return;
    } else {
      setState(() => playbackState = state);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<KantanPlaybackState>(
      playPauseButtonControllerProvider,
      (_, state) => resolveState(state),
    );

    IconData buttonIcon = switch (playbackState) {
      KantanPlaybackState.loading ||
      KantanPlaybackState.error ||
      KantanPlaybackState.playing => Icons.pause_rounded,
      KantanPlaybackState.paused => Icons.play_arrow_rounded,
      KantanPlaybackState.completed => Icons.replay_rounded,
    };

    final style = Theme.of(
      context,
    ).extension<FloatingMiniPlayerPlayPauseButtonStyle>();

    return Container(
      decoration: style?.decoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          child: InkWell(
            onTap: ref
                .read(playPauseButtonControllerProvider.notifier)
                .activate,
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  buttonIcon,
                  color: style?.iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
