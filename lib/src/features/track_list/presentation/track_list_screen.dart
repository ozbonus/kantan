import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/presentation/floating_mini_player.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/presentation/book_cover.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class TrackListScreen extends ConsumerWidget {
  const TrackListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TrackListPaneStyle>();
    return Scaffold(
      backgroundColor: style?.decoration?.color,
      body: TrackListScreenContents(),
      floatingActionButton: FloatingMiniPlayer(),
      drawer: SettingsMenu(),
    );
  }
}

class TrackListScreenContents extends StatefulWidget {
  const TrackListScreenContents({super.key});

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
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            stretch: true,
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedOpacity(
                opacity: collapsed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(Config.appTitle),
              ),
              background: const BookCover(),
            ),
          ),
          const TracksList(),
        ],
      ),
    );
  }
}

class TracksList extends ConsumerWidget {
  const TracksList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksList = ref.watch(tracksRepositoryProvider);
    return AsyncValueSliverWidget(
      value: tracksList,
      data: (tracks) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: tracks.length,
            (context, index) => TrackListTile(
              track: tracks[index],
              index: index,
            ),
          ),
        );
      },
    );
  }
}
