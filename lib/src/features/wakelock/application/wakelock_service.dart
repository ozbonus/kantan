import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wakelock_service.g.dart';

@Riverpod(keepAlive: true)
class WakelockService extends _$WakelockService {
  @override
  bool build() {
    final initialValue =
        ref.read(settingsRepositoryProvider).requireValue.isWakelockOn;
    return initialValue;
  }

  void setIsWakelockOn(bool value) async {
    ref.read(settingsRepositoryProvider).requireValue.setIsWakelockOn(value);
    state = value;
  }
}
