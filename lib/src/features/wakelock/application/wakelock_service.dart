import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';

part 'wakelock_service.g.dart';

@riverpod
class WakelockService extends _$WakelockService {
  @override
  bool build() {
    try {
      final initialState = ref
          .read(settingsRepositoryProvider)
          .requireValue
          .isWakelockOn;
      WakelockPlus.toggle(enable: initialState);
      log('Successfully initialized wakelock service, enabled: $initialState');
      return initialState;
    } on Exception catch (error, stackTrace) {
      log('Failed to initialize wakelock service: $error');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  void setIsWakelockOn(bool value) {
    try {
      WakelockPlus.toggle(enable: value);
      ref.read(settingsRepositoryProvider).requireValue.setIsWakelockOn(value);
      state = value;
    } on Exception catch (error, stackTrace) {
      log('Failed to toggle wake lock: $error');
      log('Stack trace: $stackTrace');
    }
  }
}
