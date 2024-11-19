import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/track_list/presentation/track_list_controller.dart';
import '../../../mocks/create_container.dart';

void main() {
  test("Init and return a value.", () async {
    final container = createContainer(overrides: [
      queueIndexStreamProvider.overrideWith((ref) => Stream<int>.value(0)),
    ]);
    final subscription = container.listen(
      trackListControllerProvider,
      (prev, next) {},
    );
    expect(subscription.read(), equals(const AsyncLoading<int?>()));
    await container.pump();
    expect(subscription.read(), equals(const AsyncData<int?>(0)));
    subscription.close();
  });
}
