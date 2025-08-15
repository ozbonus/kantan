import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen_contents.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_screen_title_controller.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

/// A wrapper widget for small displays, such as smart phones, that show the
/// transcript as a single screen.
class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<TranscriptScreenStyle>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: style?.backgroundColor,
        elevation: style?.appBarElevation,
        scrolledUnderElevation: style?.appBarScrolledUnderElevation,
        title: Consumer(
          // Use the title of the current track, or nothing if null.
          builder: (context, ref, _) {
            final title = ref.watch(transcriptScreenTitleControllerProvider);
            return Text(title ?? '');
          },
        ),
      ),
      body: const Center(
        child: TranscriptScreenContents(
          isFullscreen: true,
        ),
      ),
    );
  }
}
