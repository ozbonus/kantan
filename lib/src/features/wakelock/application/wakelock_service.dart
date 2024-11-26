import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wakelock_service.g.dart';

@Riverpod(keepAlive: true)
class WakelockService extends _$WakelockService {
  @override
  bool build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.isWakelockOn;
    return initialState;
  }

  void setIsWakelockOn(bool value) async {
    ref.read(settingsRepositoryProvider).requireValue.setIsWakelockOn(value);
    state = value;
  }
}
