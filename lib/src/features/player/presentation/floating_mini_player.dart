import 'package:flutter/material.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/presentation/mini_player_play_pause_button.dart';
import 'package:kantan/src/features/player/presentation/mini_player_track_info_button.dart';

class FloatingMiniPlayer extends StatelessWidget {
  const FloatingMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final miniPlayerWidth = screenWidth * Config.miniPlayerWidthProportion;

    return Container(
      width: miniPlayerWidth,
      height: Config.miniPlayerButtonSize,
      constraints: BoxConstraints(
        maxWidth: Config.miniPlayerMaxWidth,
      ),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 16.0,
        children: [
          SizedBox(
            width: Config.miniPlayerButtonSize,
            height: Config.miniPlayerButtonSize,
            child: const MiniPlayerPlayPauseButton(),
          ),
          Expanded(
            child: const MiniPlayerTrackInfoButton(),
          ),
        ],
      ),
    );
  }
}
