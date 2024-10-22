import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/settings/domain/setting_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, Object> nullValues = {};
const Map<String, Object> fullValues = {
  SettingKey.debugBool: true,
  SettingKey.debugInt: 0,
  SettingKey.debugString: 'fnord',
};

Future<SettingsRepository> makeRepository(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final repository = SettingsRepository(prefs);
  return repository;
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  test('Get full values.', () async {
    final repository = await makeRepository(fullValues);
    expect(repository.debugBool, true);
    expect(repository.debugInt, 0);
    expect(repository.debugString, 'fnord');
  });

  test('Get null values.', () async {
    final repository = await makeRepository(nullValues);
    expect(repository.debugBool, null);
    expect(repository.debugInt, null);
    expect(repository.debugString, null);
  });

  test('Write and read values.', () async {
    final repository = await makeRepository(nullValues);
    expectLater(repository.setDebugBool(true), completion(true));
    expectLater(repository.setDebugInt(1), completion(true));
    expectLater(repository.setDebugString('fnord'), completion(true));
    expect(repository.debugBool, true);
    expect(repository.debugInt, 1);
    expect(repository.debugString, 'fnord');
  });
}
