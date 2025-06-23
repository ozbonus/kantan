import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:kantan/src/routing/app_router.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class MiniPlayerTrackInfoButton extends ConsumerWidget {
  const MiniPlayerTrackInfoButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackValue = ref.watch(currentTrackStreamProvider);
    final localizations = AppLocalizations.of(context)!;

    final style = Theme.of(
      context,
    ).extension<FloatingMiniPlayerTrackInfoButton>();
    final trackNumberTextStyle = style?.trackNumberTextStyle;
    final trackNameTextStyle = style?.trackNameTextStyle;

    String trackNumberString(Track track) {
      final trackObject = localizations.trackObject;
      final discObject = localizations.discObject;
      final trackNumber = track.track;
      final discNumber = track.disc;
      final multiDisc = track.discTotal != '1';

      if (multiDisc) {
        return '$discObject $discNumber $trackObject $trackNumber';
      } else {
        return '$trackObject $trackNumber';
      }
    }

    return Container(
      decoration: style?.decoration ?? BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Material(
        type: MaterialType.transparency,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          child: InkWell(
            onTap: () => context.goNamed(AppRoute.player),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AsyncValueWidget(
                value: trackValue,
                data: (track) {
                  if (track != null) {
                    return Localizations.override(
                      context: context,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trackNumberString(track),
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.merge(trackNumberTextStyle),
                          ),
                          Text(
                            track.title,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.merge(trackNameTextStyle),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// TrackInfoAndPlayScreenLauncherButton

// class MiniPlayerPlayPauseButton extends ConsumerWidget {
//   const MiniPlayerPlayPauseButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final playbackState = ref.watch(playPauseButtonControllerProvider);
//     final localizations = AppLocalizations.of(context)!;

//     IconData buttonIcon = switch (playbackState) {
//       KantanPlaybackState.loading ||
//       KantanPlaybackState.error ||
//       KantanPlaybackState.playing => Icons.pause_rounded,
//       KantanPlaybackState.paused => Icons.play_arrow_rounded,
//       KantanPlaybackState.completed => Icons.replay_rounded,
//     };

//     String toolTip = switch (playbackState) {
//       KantanPlaybackState.error ||
//       KantanPlaybackState.loading => localizations.loadingButtonTooltip,
//       KantanPlaybackState.paused => localizations.pauseButtonTooltip,
//       KantanPlaybackState.playing => localizations.playButtonTooltip,
//       KantanPlaybackState.completed => localizations.replayButtonTooltip,
//     };

//     return Container(
//       decoration: BoxDecoration(),
//       // height: 60,
//       // width: 60,
//       clipBehavior: Clip.antiAlias,
//       child: Tooltip(
//         preferBelow: false,
//         message: toolTip,
//         child: Material(
//           type: MaterialType.transparency,
//           clipBehavior: Clip.antiAlias,
//           child: Ink(
//             child: InkWell(
//               onTap: ref
//                   .read(playPauseButtonControllerProvider.notifier)
//                   .activate,
//               child: SizedBox.expand(
//                 child: FittedBox(
//                   fit: BoxFit.contain,
//                   child: Icon(buttonIcon),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
