import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/features/settings/presentation/app_about_dialog_controller.dart';

class AppAboutDialog extends ConsumerWidget {
  const AppAboutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerValue = ref.watch(appAboutDialogControllerProvider);
    final localizations = AppLocalizations.of(context)!;

    void handleTap() => controllerValue.when(
      loading: () => showAdaptiveAboutDialog(
        context: context,
        applicationName: Config.appTitle,
      ),
      error: (_, __) => showAdaptiveAboutDialog(
        context: context,
        applicationName: Config.appTitle,
      ),
      data: (info) => showAdaptiveAboutDialog(
        context: context,
        applicationName: Config.appTitle,
        applicationVersion: info.version,
      ),
    );

    return ListTile(
      leading: const Icon(Icons.info_outline_rounded),
      title: Text(localizations.aboutAndInfoTileLabel(Config.appTitle)),
      onTap: handleTap,
    );
  }
}
