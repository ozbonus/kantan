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
      secondary: const Icon(Icons.lightbulb_outline_rounded),
      value: isWakelockOn,
      onChanged: (value) => ref
          .read(wakelockSwitchControllerProvider.notifier)
          .setIsWakelockOn(value),
    );
  }
}
