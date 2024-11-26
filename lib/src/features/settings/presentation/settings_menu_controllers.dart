import 'package:kantan/src/features/wakelock/application/wakelock_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_menu_controllers.g.dart';

@riverpod
class WakelockSwitchController extends _$WakelockSwitchController {
  @override
  bool build() {
    return ref.watch(wakelockServiceProvider);
  }

  void setIsWakelockOn(bool value) {
    ref.read(wakelockServiceProvider.notifier).setIsWakelockOn(value);
    state = value;
  }
}
