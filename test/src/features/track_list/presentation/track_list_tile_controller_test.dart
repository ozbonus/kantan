import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_tile_controller.dart';
import '../../../../mocks/create_container.dart';

void main() {
  test('AsyncLoading during init returns null.', () async {
    final container = createContainer(
      overrides: [
        queueIndexStreamProvider.overrideWith((ref) => Stream<int>.value(0)),
      ],
    );

    final subscription = container.listen(
      trackListTileControllerProvider(0),
      (prev, next) {},
    );

    expect(subscription.read(), isNull);
  });

  test('Matching indices returns true.', () async {
    final container = createContainer(
      overrides: [
        queueIndexStreamProvider.overrideWith((ref) => Stream<int>.value(0)),
      ],
    );

    final subscription = container.listen(
      trackListTileControllerProvider(0),
      (prev, next) {},
    );

    await container.pump();
    expect(subscription.read(), isTrue);
  });

  test('Non-matching indices returns false.', () async {
    final container = createContainer(
      overrides: [
        queueIndexStreamProvider.overrideWith((ref) => Stream<int>.value(0)),
      ],
    );

    final subscription = container.listen(
      trackListTileControllerProvider(0),
      (prev, next) {},
    );

    await container.pump();
    expect(subscription.read(), isTrue);
  });

  test('AsyncError returns null.', () async {
    final container = createContainer(
      overrides: [
        queueIndexStreamProvider.overrideWith((ref) => Stream.error('')),
      ],
    );

    final subscription = container.listen(
      trackListTileControllerProvider(0),
      (prev, next) {},
    );

    await container.pump();
    expect(subscription.read(), isNull);
  });
}
