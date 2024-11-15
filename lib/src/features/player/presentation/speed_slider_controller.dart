import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'speed_slider_controller.g.dart';

@riverpod
AsyncValue<double> speed(Ref ref) {
  return ref.watch(speedStreamProvider);
}

@riverpod
setSpeed(Ref ref, double speed) {
  return ref.read(audioHandlerProvider).requireValue.setSpeed(speed);
}
