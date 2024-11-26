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
        children: [
          const WakelockSwitch(),
        ],
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
      value: isWakelockOn,
      onChanged: (value) => ref
          .read(wakelockSwitchControllerProvider.notifier)
          .setIsWakelockOn(value),
      title: Text('Keep screen on'.hardcoded),
    );
  }
}
