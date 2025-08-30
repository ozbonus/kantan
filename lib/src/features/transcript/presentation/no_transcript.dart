import 'package:flutter/material.dart';
import 'package:kantan/l10n/app_localizations.dart';

class NoTranscript extends StatelessWidget {
  const NoTranscript({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Center(child: Text(localizations!.noTranscriptMessage));
  }
}
