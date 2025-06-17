import 'dart:ui';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translation_locale_service.g.dart';

@riverpod
class TranslationLocaleService extends _$TranslationLocaleService {
  @override
  Locale? build() {
    final initialState = ref
        .read(settingsRepositoryProvider)
        .requireValue
        .translationLocale;
    return initialState;
  }

  void setTranslationLocale(Locale? locale) {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setTranslationLocale(locale);
    state = locale;
  }
}
