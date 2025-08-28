import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/transcript/domain/transcript.dart';
import 'package:kantan/src/features/transcript/presentation/transcript_line_widget.dart';
import 'package:kantan/src/themes/theme_extensions.dart';

class StaticTranscript extends ConsumerWidget {
  const StaticTranscript({
    super.key,
    required this.transcript,
    this.translation,
  });
  final Transcript transcript;
  final Transcript? translation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).extension<TranscriptScreenStyle>();
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bottomPaddingFactor =
        style?.bottomPaddingFactor ??
        TranscriptScreenStyle.defaultBottomPaddingFactor;
    final bottomPadding = screenHeight * bottomPaddingFactor;
    return ListView.builder(
      itemCount: transcript.lines.length,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      itemBuilder: (context, index) => TranscriptLineWidget(
        index: index,
        transcript: transcript,
        translation: translation,
      ),
    );
  }
}
