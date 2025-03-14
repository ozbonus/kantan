import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_translation_service.g.dart';

@riverpod
class ShowTranslationService extends _$ShowTranslationService {
  @override
  bool build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.showTranslation;
    return initialState;
  }

  void setShowTranslation(bool value) {
    ref.read(settingsRepositoryProvider).requireValue.setShowTranslation(value);
    state = value;
  }
}
