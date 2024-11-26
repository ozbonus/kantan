import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parental_mode_service.g.dart';

@riverpod
class ParentalModeService extends _$ParentalModeService {
  @override
  bool build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.isParentalModeOn;
    return initialState;
  }

  void setIsParentalModeOn(bool value) {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setIsParentalModeOn(value);
    state = value;
  }
}
