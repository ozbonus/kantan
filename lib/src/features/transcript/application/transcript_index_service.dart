import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transcript_index_service.g.dart';

// This is a keep alive class in order to avoid the transcript briefly jumping
// around when navigating back to transcript screen.
@Riverpod(keepAlive: true)
class TranscriptIndexService extends _$TranscriptIndexService {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    /// Update the notifier's state only if
    if (index != state) {
      state = index;
    }
  }
}
