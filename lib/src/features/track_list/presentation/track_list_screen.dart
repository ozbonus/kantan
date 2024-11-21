import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/presentation/floating_mini_player.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile.dart';
import 'package:kantan/src/routing/app_router.dart';

class TrackListScreen extends ConsumerWidget {
  const TrackListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioHandler = ref.watch(audioHandlerProvider).requireValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(Config.appTitle),
      ),
      body: const TracksList(),
      floatingActionButton: const FloatingMiniPlayer(),
    );
  }
}

class TracksList extends ConsumerWidget {
  const TracksList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracksList = ref.watch(tracksListProvider);
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
