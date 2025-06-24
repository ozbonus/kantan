import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/presentation/floating_mini_player.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_app_bar.dart';
import 'package:kantan/src/features/track_list/presentation/tracks_list.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class TrackListScreen extends ConsumerWidget {
  const TrackListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TrackListPaneStyle>();
    return Scaffold(
      backgroundColor: style?.decoration?.color,
      body: TrackListScreenContents(isFullscreen: true),
      floatingActionButton: const FloatingMiniPlayer(),
      drawer: const SettingsMenu(),
    );
  }
}

class TrackListScreenContents extends StatefulWidget {
  const TrackListScreenContents({
    super.key,
    this.isFullscreen = false,
  });

  final bool isFullscreen;

  @override
  State<TrackListScreenContents> createState() =>
      _TrackListScreenContentsState();
}

class _TrackListScreenContentsState extends State<TrackListScreenContents> {
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    // This listener nonsense is required because there's no simple way to show
    // a sliver app bar title only when it is collapsed. The magic integer in
    // the control flow will vary based on the expanded height of the sliver app
    // bar.
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels > 330 && !collapsed) {
          setState(() => collapsed = true);
        } else if (notification.metrics.pixels < 330 && collapsed) {
          setState(() => collapsed = false);
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          TrackListAppBar(
            isFullscreen: widget.isFullscreen,
            collapsed: collapsed,
          ),
          const TracksList(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Config.trackListScrollBottomPadding,
            ),
          ),
        ],
      ),
    );
  }
}
