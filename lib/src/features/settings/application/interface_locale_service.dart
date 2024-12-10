import 'dart:ui';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interface_locale_service.g.dart';

@riverpod
class InterfaceLocaleService extends _$InterfaceLocaleService {
  @override
  Locale? build() {
    final initialState =
        ref.watch(settingsRepositoryProvider).requireValue.interfaceLocale;
    return initialState;
  }

  void setInterfaceLocale(Locale? locale) {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setInterfaceLocale(locale);
    state = locale;
  }
}
