import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:mockito/mockito.dart';

class FakeSettingsRepository extends Fake implements SettingsRepository {
  @override
  int get queueIndex => 1;

  @override
  Duration get position => const Duration(seconds: 1);

  @override
  double get speed => 1.5;

  @override
  RepeatMode get repeatMode => RepeatMode.one;
}
