import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile_controller.dart';

class TrackListTile extends ConsumerWidget {
  const TrackListTile({
    super.key,
    required this.track,
    required this.index,
  });

  final Track track;
  final int index;

  bool _trailing(bool? selected) {
    if (selected != null) {
      return selected;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool? selected = ref.watch(trackListTileControllerProvider(index));
    return ListTile(
      leading: Text(track.track.toString()),
      title: Text(track.title),
      selected: selected ?? false,
      onTap: () => ref
          .read(trackListTileControllerProvider(index).notifier)
          .skipToTrack(index),
      trailing:
          _trailing(selected) ? const Icon(Icons.play_arrow_rounded) : null,
    );
  }
}
