import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'can_see_translation_service.g.dart';

@riverpod
class CanSeeTranslationService extends _$CanSeeTranslationService {
  @override
  bool build() {
    final initialState = ref
        .read(settingsRepositoryProvider)
        .requireValue
        .canSeeTranslation;
    return initialState;
  }

  void setCanSeeTranslation(bool value) {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setCanSeeTranslation(value);
    state = value;
  }
}
