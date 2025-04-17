import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/presentation/buttons.dart';
import 'package:kantan/src/features/player/presentation/open_transcript_button_controller.dart';
import 'package:kantan/src/features/player/presentation/progress_slider.dart';
import 'package:kantan/src/features/player/presentation/repeat_mode_button_controller.dart';
import 'package:kantan/src/features/player/presentation/speed_slider.dart';
import 'package:kantan/src/routing/app_router.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Screen'),
      ),
      body: const PlayerScreenContents(),
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
        showOpenTranscriptButtonControllerProvider(isFullscreen, screenWidth));
    return Container(
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end, // Removable?
          children: [
            TrackInfo(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 420),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ResponsiveButtonGrid(
                      showOpenTranscriptButton: showOpenTranscriptButton,
                    ),
                  ),
                ),
              ),
            )
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
        print(constraints.maxHeight);
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
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
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
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
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
          crossAxisCellCount: 3,
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
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
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
    return AsyncValueWidget(
      value: trackValue,
      data: (track) {
        if (track != null) {
          return Column(
            children: [
              Text('${track.track} ${track.title}'),
              if (track.displayDescription != null)
                Text('${track.displayDescription}')
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
