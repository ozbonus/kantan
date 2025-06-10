import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/presentation/buttons.dart';
import 'package:kantan/src/features/player/presentation/open_transcript_button_controller.dart';
import 'package:kantan/src/features/player/presentation/progress_slider.dart';
import 'package:kantan/src/features/player/presentation/speed_slider.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerPaneStyle>();
    final foregroundColor = style?.appBarForegroundColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor,
        iconTheme: IconThemeData(color: foregroundColor),
        title: Text(Config.appTitle),
      ),
      body: const PlayerScreenContents(),
      extendBodyBehindAppBar: true,
    );
  }
}

class PlayerScreenContents extends ConsumerWidget {
  const PlayerScreenContents({
    this.isFullscreen = false,
    super.key,
  });

  final bool isFullscreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final showOpenTranscriptButton = ref.watch(
      showOpenTranscriptButtonControllerProvider(isFullscreen, screenWidth),
    );
    final style = Theme.of(context).extension<PlayerPaneStyle>();
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: style?.containerDecoration?.gradient,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end, // Removable?
          children: [
            const TrackInfo(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Config.buttonGridMaxWidth,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ResponsiveButtonGrid(
                      showOpenTranscriptButton: showOpenTranscriptButton,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveButtonGrid extends StatelessWidget {
  const ResponsiveButtonGrid({
    super.key,
    this.showOpenTranscriptButton = false,
  });

  final bool showOpenTranscriptButton;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxHeight > Config.fullButtonGridBreakpoint) {
          return ButtonGrid(
            showOpenTranscriptButton: showOpenTranscriptButton,
          );
        } else if (constraints.maxHeight >= Config.smallButtonGridBreakpoint) {
          return SmallButtonGrid(
            showOpenTranscriptButton: showOpenTranscriptButton,
          );
        } else {
          return VerySmallButtonGrid(
            showOpenTranscriptButton: showOpenTranscriptButton,
          );
        }
      },
    );
  }
}

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({
    super.key,
    this.showOpenTranscriptButton = false,
  });

  final bool showOpenTranscriptButton;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerScreenControlsStyle>();
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: style?.mainAxisSpacing ?? 0,
      crossAxisSpacing: style?.crossAxisSpacing ?? 0,
      children: [
        StaggeredGridTile.count(
          mainAxisCellCount: 3,
          crossAxisCellCount: 2,
          child: const PlayPauseButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 1,
          child: const SkipToPreviousButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 1,
          child: const SkipToNextButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 1,
          child: const RewindButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 1,
          child: const FastForwardButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 2,
          child: const RepeatModeButton(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 4,
          child: const SpeedSlider(),
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: 4,
          child: const ProgressSlider(),
        ),
        if (showOpenTranscriptButton)
          StaggeredGridTile.fit(
            crossAxisCellCount: 4,
            child: const OpenTranscriptButton(),
          ),
      ],
    );
  }
}

class SmallButtonGrid extends StatelessWidget {
  const SmallButtonGrid({
    super.key,
    this.showOpenTranscriptButton = false,
  });

  final bool showOpenTranscriptButton;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerScreenControlsStyle>();
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: style?.mainAxisSpacing ?? 0,
      crossAxisSpacing: style?.crossAxisSpacing ?? 0,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: const PlayPauseButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const SkipToPreviousButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const SkipToNextButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const RewindButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const FastForwardButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 3,
          mainAxisCellCount: 1,
          child: const SpeedSlider(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const RepeatModeButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 1,
          child: const ProgressSlider(),
        ),
        if (showOpenTranscriptButton)
          StaggeredGridTile.fit(
            crossAxisCellCount: 4,
            child: const OpenTranscriptButton(),
          ),
      ],
    );
  }
}

class VerySmallButtonGrid extends StatelessWidget {
  const VerySmallButtonGrid({
    super.key,
    this.showOpenTranscriptButton = false,
  });

  final bool showOpenTranscriptButton;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<PlayerScreenControlsStyle>();
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: style?.mainAxisSpacing ?? 0,
      crossAxisSpacing: style?.crossAxisSpacing ?? 0,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const PlayPauseButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const SkipToPreviousButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const SkipToNextButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: const RepeatModeButton(),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: showOpenTranscriptButton ? 3 : 4,
          mainAxisCellCount: 1,
          child: const SpeedSlider(),
        ),
        if (showOpenTranscriptButton)
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1,
            child: const OpenTranscriptButton(iconOnly: true),
          ),
        StaggeredGridTile.count(
          crossAxisCellCount: 4,
          mainAxisCellCount: 1,
          child: const ProgressSlider(),
        ),
      ],
    );
  }
}

class TrackInfo extends ConsumerWidget {
  const TrackInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackValue = ref.watch(currentTrackStreamProvider);
    final localizations = AppLocalizations.of(context)!;
    final style = Theme.of(context).extension<PlayerPaneStyle>();
    final trackNumberTextStyle = style?.trackNumberTextStyle;
    final trackTitleTextStyle = style?.trackTitleTextStyle;
    final trackDescriptionTextStyle = style?.trackDescriptionTextStyle;

    String _trackNumberString(Track track) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: AsyncValueWidget(
        value: trackValue,
        data: (track) {
          if (track != null) {
            return Localizations.override(
              context: context,
              locale: Config.transcriptLocale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _trackNumberString(track),
                    style: Theme.of(context).textTheme.titleLarge?.merge(
                      trackNumberTextStyle,
                    ),
                  ),
                  Text(
                    track.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.merge(trackTitleTextStyle),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  if (track.displayDescription != null)
                    Text(
                      track.displayDescription!,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.merge(trackDescriptionTextStyle),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
