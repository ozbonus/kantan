import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/settings/presentation/settings_menu_controllers.dart';
import 'package:kantan/src/localization/string_hardcoded.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          ThemeModeSwitch(),
          WakelockSwitch(),
          ParentalModeSwitch(),
          CanSeeTranscriptSwitch(),
          CanSeeTranslationSwitch(),
        ],
      ),
    );
  }
}

class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeValue = ref.watch(themeModeSwitchControllerProvider);
    return ListTile(
      title: Text('Theme'.hardcoded),
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
    final isWakelockOn = ref.watch(wakelockSwitchControllerProvider);
    return SwitchListTile(
      title: Text('Keep screen on'.hardcoded),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isParentalModeOn = ref.watch(parentalModeSwitchControllerProvider);
    return SwitchListTile(
      title: Text('Parental mode'.hardcoded),
      secondary: const Icon(Icons.family_restroom_rounded),
      value: isParentalModeOn,
      onChanged: (value) => ref
          .read(parentalModeSwitchControllerProvider.notifier)
          .setIsParentalModeOn(value),
    );
  }
}

class CanSeeTranscriptSwitch extends ConsumerWidget {
  const CanSeeTranscriptSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSee = ref.watch(canSeeTranscriptSwitchControllerProvider);
    return SwitchListTile(
      title: Text('Can see transcript'.hardcoded),
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
    final canSee = ref.watch(canSeeTranslationSwitchControllerProvider);
    return SwitchListTile(
      title: Text('Can see translation'.hardcoded),
      secondary: const Icon(Icons.translate_rounded),
      value: canSee,
      onChanged: (value) => ref
          .read(canSeeTranslationSwitchControllerProvider.notifier)
          .setCanSeeTranslation(value),
    );
  }
}
