import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/common_widgets/async_value_widget.dart';
import 'package:kantan/src/features/track_list/data/tracks_repository.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile.dart';

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
