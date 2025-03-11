import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/presentation/floating_mini_player.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile.dart';

class TrackListScreen extends ConsumerWidget {
  const TrackListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Config.appTitle),
      ),
      body: const TracksList(),
      floatingActionButton: const FloatingMiniPlayer(),
      drawer: const SettingsMenu(),
    );
  }
}

class TracksList extends ConsumerWidget {
  const TracksList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksList = ref.watch(tracksRepositoryProvider);
    return AsyncValueWidget(
      value: tracksList,
      data: (tracks) {
        return ListView.builder(
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            return TrackListTile(
              track: tracks[index],
              index: index,
            );
          },
        );
      },
    );
  }
}
