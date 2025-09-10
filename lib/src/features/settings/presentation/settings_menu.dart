import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kantan/config.dart';
import 'package:kantan/l10n/app_localizations.dart';
import 'package:kantan/src/features/parental_mode/presentation/math_challenge_screen.dart';
import 'package:kantan/src/features/settings/presentation/app_about_dialog.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu_controller.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu_controllers.dart';

class SettingsMenu extends ConsumerWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsMenuControllerProvider);
    final localizations = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                localizations.settingsAndInfoMenuTitle,
                style: Theme.of(context).textTheme.displaySmall!,
              ),
            ),
          ),
          if (controller.showThemeModeSwitch) const ThemeModeSwitch(),
          if (controller.showWakelockSwitch) const WakelockSwitch(),
          if (controller.showParentalModeSwitch) const ParentalModeSwitch(),
          if (controller.showCanSeeTranscriptSwitch)
            const CanSeeTranscriptSwitch(),
          if (controller.showCanSeeTranslationSwitch)
            const CanSeeTranslationSwitch(),
          if (controller.showInterfaceLanguageSelector)
            const InterfaceLocaleSelector(),
          if (controller.showTranslationLanguageSelector)
            const TranslationLocaleSelector(),
          const Divider(),
          const AppAboutDialog(),
        ],
      ),
    );
  }
}

class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final themeModeValue = ref.watch(themeModeSwitchControllerProvider);
    return ListTile(
      title: Text(localizations.themeMenuTitle),
      trailing: ToggleButtons(
        isSelected: List.filled(3, false)..[themeModeValue.index] = true,
        children: const [
          Icon(Icons.phone_android_rounded),
          Icon(Icons.light_mode_rounded),
          Icon(Icons.dark_mode_rounded),
        ],
        onPressed: (index) => ref
            .read(themeModeSwitchControllerProvider.notifier)
            .setThemeMode(ThemeMode.values[index]),
      ),
    );
  }
}

class WakelockSwitch extends ConsumerWidget {
  const WakelockSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isWakelockOn = ref.watch(wakelockSwitchControllerProvider);
    return SwitchListTile(
      title: Text(localizations.wakelockTileLabel),
      // secondary: const Icon(Icons.lightbulb_outline_rounded),
      secondary: isWakelockOn
          ? const Icon(Icons.lightbulb_rounded)
          : const Icon(Icons.lightbulb_outline_rounded),
      value: isWakelockOn,
      onChanged: (value) => ref
          .read(wakelockSwitchControllerProvider.notifier)
          .setIsWakelockOn(value),
    );
  }
}

class ParentalModeSwitch extends ConsumerWidget {
  const ParentalModeSwitch({super.key});

  Widget adaptiveAction({
    required BuildContext context,
    required VoidCallback onPressed,
    required Widget child,
  }) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isParentalModeOn = ref.watch(parentalModeSwitchControllerProvider);
    return SwitchListTile(
      title: Text(localizations.parentAndTeacherModeTileLabel),
      secondary: const Icon(Icons.family_restroom_rounded),
      value: isParentalModeOn,
      onChanged: (value) async {
        if (Config.useParentalModeChallengeFeature && value) {
          final bool? challengePassed = await showModalBottomSheet<bool>(
            context: context,
            enableDrag: true,
            showDragHandle: true,
            isDismissible: true,
            isScrollControlled: true,
            builder: (context) => const MathChallengeScreen(),
          );
          ref
              .read(parentalModeSwitchControllerProvider.notifier)
              .setIsParentalModeOn(challengePassed ?? false);
        } else if (Config.useParentalModeChallengeFeature && !value) {
          final bool newValue = await showAdaptiveDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              final localizations = AppLocalizations.of(context)!;
              return AlertDialog.adaptive(
                title: Text(localizations.disableModeWindowTitle),
                content: Text(localizations.mathChallengeWarning),
                actions: [
                  adaptiveAction(
                    context: context,
                    onPressed: () => context.pop(true),
                    child: Text(localizations.cancelButtonLabel),
                  ),
                  adaptiveAction(
                    context: context,
                    onPressed: () => context.pop(false),
                    child: Text(localizations.okButtonText),
                  ),
                ],
              );
            },
          );
          ref
              .read(parentalModeSwitchControllerProvider.notifier)
              .setIsParentalModeOn(newValue);
        } else {
          ref
              .read(parentalModeSwitchControllerProvider.notifier)
              .setIsParentalModeOn(value);
        }
      },
    );
  }
}

class CanSeeTranscriptSwitch extends ConsumerWidget {
  const CanSeeTranscriptSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final canSee = ref.watch(canSeeTranscriptSwitchControllerProvider);
    return SwitchListTile(
      title: Text(localizations.canSeeTranscriptTileLabel),
      secondary: const Icon(Icons.chat_rounded),
      value: canSee,
      onChanged: (value) => ref
          .read(canSeeTranscriptSwitchControllerProvider.notifier)
          .setCanSeeTranscript(value),
    );
  }
}

class CanSeeTranslationSwitch extends ConsumerWidget {
  const CanSeeTranslationSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final canSee = ref.watch(canSeeTranslationSwitchControllerProvider);
    return SwitchListTile(
      title: Text(localizations.canSeeTranslationTileLabel),
      secondary: const Icon(Icons.translate_rounded),
      value: canSee,
      onChanged: (value) => ref
          .read(canSeeTranslationSwitchControllerProvider.notifier)
          .setCanSeeTranslation(value),
    );
  }
}

class InterfaceLocaleSelector extends StatelessWidget {
  const InterfaceLocaleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    const supportedLocales = AppLocalizations.supportedLocales;
    return ExpansionTile(
      leading: const Icon(Icons.language_rounded),
      title: Text(localizations.appLanguageListTileLabel),
      children: [
        ListTile(title: Text(localizations.appLanguageDescription)),
        const InterfaceLocaleSelectorOption(null),
        ...supportedLocales.map(
          (locale) => InterfaceLocaleSelectorOption(locale),
        ),
      ],
    );
  }
}

class InterfaceLocaleSelectorOption extends ConsumerWidget {
  const InterfaceLocaleSelectorOption(this.locale, {super.key});
  final Locale? locale;

  String nativeLocaleString(BuildContext context, Locale locale) {
    final nativeNames = LocaleNamesLocalizationsDelegate.nativeLocaleNames;
    final languageTags = locale.toLanguageTag().replaceAll('-', '_');
    final nativeName = nativeNames[languageTags];
    return nativeName ?? 'Native name not found';
  }

  String localizedLocaleString(BuildContext context) {
    final languageTags = locale!.toLanguageTag().replaceAll('-', '_');
    final localeNameString = LocaleNames.of(context)!.nameOf(languageTags);
    return localeNameString ?? languageTags;
  }

  String titleString(BuildContext context) {
    if (locale == null) {
      final localizations = AppLocalizations.of(context);
      return localizations!.defaultLanguageOptionLabel;
    } else {
      return nativeLocaleString(context, locale!);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(interfaceLocaleOptionControllerProvider);
    final isSelected = locale == currentLocale;
    return ListTile(
      selected: isSelected,
      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
      title: Text(titleString(context)),
      subtitle: locale != null ? Text(localizedLocaleString(context)) : null,
      onTap: () => ref
          .read(interfaceLocaleOptionControllerProvider.notifier)
          .setInterfaceLocale(locale),
    );
  }
}

class TranslationLocaleSelector extends StatelessWidget {
  const TranslationLocaleSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final supportedLocales = Config.translationLocales;
    return ExpansionTile(
      leading: const Icon(Icons.translate_rounded),
      title: Text(localizations.translationLanguageListTileLabel),
      children: [
        ListTile(title: Text(localizations.translationLanguageDescription)),
        const TranslationLocaleSelectorOption(null),
        ...supportedLocales.map(
          (locale) => TranslationLocaleSelectorOption(locale),
        ),
      ],
    );
  }
}

class TranslationLocaleSelectorOption extends ConsumerWidget {
  const TranslationLocaleSelectorOption(this.locale, {super.key});
  final Locale? locale;

  String nativeLocaleString(BuildContext context, Locale locale) {
    final nativeNames = LocaleNamesLocalizationsDelegate.nativeLocaleNames;
    final languageTags = locale.toLanguageTag().replaceAll('-', '_');
    final nativeName = nativeNames[languageTags];
    return nativeName ?? 'Native name not found';
  }

  String localizedLocaleString(BuildContext context) {
    final languageTags = locale!.toLanguageTag().replaceAll('-', '_');
    final localeNameString = LocaleNames.of(context)!.nameOf(languageTags);
    return localeNameString ?? languageTags;
  }

  String titleString(BuildContext context) {
    if (locale == null) {
      final localizations = AppLocalizations.of(context);
      return localizations!.noTranslationLanguageOptionLabel;
    } else {
      return nativeLocaleString(context, locale!);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(translationLocaleOptionControllerProvider);
    final isSelected = locale == currentLocale;
    return ListTile(
      selected: isSelected,
      trailing: isSelected ? const Icon(Icons.check_rounded) : null,
      title: Text(titleString(context)),
      subtitle: locale != null ? Text(localizedLocaleString(context)) : null,
      onTap: () => ref
          .read(translationLocaleOptionControllerProvider.notifier)
          .setTranslationLocale(locale),
    );
  }
}
