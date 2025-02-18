import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';

part 'enable_auto_scroll_service.g.dart';

@riverpod
class EnableAutoScrollService extends _$EnableAutoScrollService {
  @override
  bool build() {
    final initialState =
        ref.read(settingsRepositoryProvider).requireValue.enableAutoScroll;
    return initialState;
  }

  void setEnableAutoScroll(bool value) async {
    ref
        .read(settingsRepositoryProvider)
        .requireValue
        .setEnableAutoScroll(value);
    state = value;
  }
}
