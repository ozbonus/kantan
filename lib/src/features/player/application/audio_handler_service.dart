import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kantan/config.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/domain/position_data.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:kantan/src/features/settings/data/settings_repository.dart';
import 'package:kantan/src/features/track_list/data/track_to_media_item.dart';
import 'package:kantan/src/features/track_list/domain/track.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'audio_handler_service.g.dart';

class AudioHandlerService extends BaseAudioHandler {
  AudioHandlerService() {
    _createAudioSession();
    _loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForCurrentSongIndexChanges();
    _listenForDurationChanges();
    _listenForPlaybackStateChanges();
  }

  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  final kantanPlaybackState = BehaviorSubject.seeded(
    KantanPlaybackState.loading,
  );

  late Timer _saveStateTimer;
  late Ref ref;

  @visibleForTesting
  @protected
  AudioPlayer get player => _player;

  Future<void> _createAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  Future<void> _loadEmptyPlaylist() async {
    try {
      await _player.setAudioSource(_playlist);
    } catch (e, st) {
      throw Exception('AudioHandlerService._loadEmptyPlaylist(): $e $st');
    }
  }

  void _listenForCurrentSongIndexChanges() {
    _player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) {
        return;
      }
      mediaItem.add(playlist[index]);
    });
  }

  // audio_service needs a duration in order to make the system ui progress bar.
  // However, when just_audio loads a new audio source the duration isn't
  // immediately available and its duration is given as null. This method
  // listens for when the duration is ready and swaps out the current MediaItem
  // for a new version that has the correct duration. Changing the MediaItem
  // requires also updating the queue, according the semi-official tutorial.
  // TODO: Can this made shorter or avoided altogether?
  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) {
      final index = _player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      playbackState.add(
        playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            MediaControl.rewind,
            playing ? MediaControl.pause : MediaControl.play,
            MediaControl.fastForward,
            MediaControl.skipToNext,
          ],
          systemActions: const {
            MediaAction.seek,
          },
          androidCompactActionIndices: const [0, 2, 4],
          processingState: const {
            ProcessingState.idle: AudioProcessingState.idle,
            ProcessingState.loading: AudioProcessingState.loading,
            ProcessingState.buffering: AudioProcessingState.buffering,
            ProcessingState.ready: AudioProcessingState.ready,
            ProcessingState.completed: AudioProcessingState.completed,
          }[_player.processingState]!,
          playing: playing,
          updatePosition: _player.position,
          bufferedPosition: _player.bufferedPosition,
          speed: _player.speed,
          queueIndex: event.currentIndex,
        ),
      );
    });
  }

  void loadState(Ref ref) async {
    final repository = ref.watch(settingsRepositoryProvider).requireValue;
    final queueIndex = repository.queueIndex;
    final position = repository.position;
    final speed = repository.speed;
    final repeatMode = repository.repeatMode;

    await _player.seek(position, index: queueIndex);
    await _player.setSpeed(speed);
    switch (repeatMode) {
      case RepeatMode.none:
        await setRepeatMode(AudioServiceRepeatMode.none);
      case RepeatMode.one:
        await setRepeatMode(AudioServiceRepeatMode.one);
      case RepeatMode.all:
        await setRepeatMode(AudioServiceRepeatMode.all);
    }
  }

  void saveState(Ref ref) {
    final repository = ref.watch(settingsRepositoryProvider).requireValue;
    _saveStateTimer = Timer.periodic(
      Config.saveStateUpdateDuration,
      (timer) {
        print(_player.position);
        repository.setPosition(_player.position);
      },
    );
  }

  // audio_service relies on MediaItem, but just_audio relies on AudioSource. In
  // a Kantan Player app the tracks repository provdies a list of MediaItems
  // wherein the required id field is the same as the local asset's location.
  AudioSource _createAudioSourceFromMediaItem(MediaItem item) {
    final uri = 'asset:///packages/${Config.assetsPackage}/assets/${item.id}';
    return AudioSource.uri(Uri.parse(uri));
  }

  Future<void> dispose() async {
    _saveStateTimer.cancel();
    await _player.dispose();
  }

  @override
  Future<void> onNotificationDeleted() async {
    return;
  }

  Future<void> loadTrack(Track track) {
    final mediaItem = track.mediaItem;
    return addQueueItem(mediaItem);
  }

  Future<void> loadTracks(List<Track> tracks) {
    final mediaItems = tracks.map((track) => track.mediaItem).toList();
    return addQueueItems(mediaItems);
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // Manage just_audio.
    final AudioSource audioSource = _createAudioSourceFromMediaItem(mediaItem);
    _playlist.add(audioSource);

    // Manage audio_service.
    final newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // Manage just_audio.
    final List<AudioSource> audioSources = mediaItems.map((mediaItem) {
      return _createAudioSourceFromMediaItem(mediaItem);
    }).toList();
    _playlist.addAll(audioSources);

    // Manage audio_service.
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // Manage just_audio.
    _playlist.removeAt(index);

    // Manage audio_service.
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  // For some as yet unknown reason, we have to call this method after adding
  // tracks to the queue or the player will remain in a loading state. Maybe
  // just during tests though.
  // TODO: Figure this out.
  Future<void> load() => _player.load();

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.dispose();
    await super.stop();
  }

  // TODO: Check if this works properly now.
  @override
  Future<void> skipToQueueItem(int index) async {
    await _player.seek(Duration.zero, index: index);
  }

  // The hasNext getter built into just_audio has a weird quirk wherein it will
  // always return true when AudioPlayer.loopMode is set to any of the repeating
  // versions. This leads to a wrong result when playing the first or last track
  // in a playlist.
  bool get hasNext => _player.currentIndex! < _player.sequence!.length - 1;

  // just_audio's hasPrevious getter suffers the same issue as its hasNext.
  bool get hasPrevious => _player.currentIndex! > 0;

  // The seekToNext and seekToPrevious methods that are built into just_audio
  // exhibit bizarre, yet nevertheless intentional behavior when
  // AudioPlayer.loopMode is set to LoopMode.one. In such a case either method
  // will seek back to the beginning of the currently-playing track, regardless
  // whether or not a previous or next track exists in the queue. Known issue.
  // https://github.com/ryanheise/just_audio/issues/862
  @override
  Future<void> skipToNext() async {
    if (hasNext) {
      final nextTrack = _player.currentIndex! + 1;
      // TODO: Check that this call works properly being called just once.
      await _player.seek(Duration.zero, index: nextTrack);
    } else {
      return;
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (hasPrevious) {
      final previousTrack = _player.currentIndex! - 1;
      // TODO: Check that this call works properly being called just once.
      await _player.seek(Duration.zero, index: previousTrack);
    } else {
      return;
    }
  }

  @override
  Future<void> seek(Duration position) async => _player.seek(position);

  // just_audio may briefly report an errorenous current position when the
  // default implementations of fast forward and rewind go beyond the bounds of
  // the current audio source. For example, rewinding 5 seconds when the current
  // position is 3 seconds. Thus the custom implementations of these two methods
  // below.
  @override
  Future<void> fastForward() async {
    final currentDuration = _player.duration;
    final fastForwardDuration = Config.rewindDuration;
    final desiredPosition = _player.position + fastForwardDuration;
    if (currentDuration == null) {
      return;
    } else if (desiredPosition < currentDuration) {
      return _player.seek(desiredPosition);
    } else {
      // Seek to the end of the current audio source.
      return _player.seek(currentDuration);
    }
  }

  @override
  Future<void> rewind() async {
    final currentDuration = _player.duration;
    final rewindDuration = Config.rewindDuration;
    debugPrint(rewindDuration.toString());
    final desiredPosition = _player.position - rewindDuration;
    if (currentDuration == null) {
      return;
    } else if (desiredPosition > Duration.zero) {
      return _player.seek(desiredPosition);
    } else {
      // Seek to the beginning of the current audio source.
      return _player.seek(Duration.zero);
    }
  }

  @override
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.none:
        _player.setLoopMode(LoopMode.off);
        playbackState.add(
          playbackState.value.copyWith(
            repeatMode: AudioServiceRepeatMode.none,
          ),
        );
      case AudioServiceRepeatMode.one:
        _player.setLoopMode(LoopMode.one);
        playbackState.add(
          playbackState.value.copyWith(
            repeatMode: AudioServiceRepeatMode.one,
          ),
        );
      case AudioServiceRepeatMode.all:
        _player.setLoopMode(LoopMode.all);
        playbackState.add(
          playbackState.value.copyWith(
            repeatMode: AudioServiceRepeatMode.all,
          ),
        );
    }
  }

  Future<void> nextRepeatMode() async {
    final audioServiceRepeatMode = playbackState.value.repeatMode;
    switch (audioServiceRepeatMode) {
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.none:
        await setRepeatMode(AudioServiceRepeatMode.one);
      case AudioServiceRepeatMode.one:
        await setRepeatMode(AudioServiceRepeatMode.all);
      case AudioServiceRepeatMode.all:
        await setRepeatMode(AudioServiceRepeatMode.none);
    }
  }

  Stream<RepeatMode> get repeatMode {
    return playbackState.map((state) {
      switch (state.repeatMode) {
        case AudioServiceRepeatMode.none:
          return RepeatMode.none;
        case AudioServiceRepeatMode.one:
          return RepeatMode.one;
        case AudioServiceRepeatMode.all:
          return RepeatMode.all;
        // Group repeat mode should be impossible.
        case AudioServiceRepeatMode.group:
          return RepeatMode.one;
      }
    });
  }

  void _listenForPlaybackStateChanges() {
    playbackState.listen((state) {
      final processingState = state.processingState;

      if (state.playing) {
        kantanPlaybackState.add(KantanPlaybackState.playing);
        return;
      }

      switch (processingState) {
        case AudioProcessingState.idle:
        case AudioProcessingState.buffering:
        case AudioProcessingState.loading:
          kantanPlaybackState.add(KantanPlaybackState.loading);
        case AudioProcessingState.ready:
          kantanPlaybackState.add(KantanPlaybackState.paused);
        case AudioProcessingState.completed:
          kantanPlaybackState.add(KantanPlaybackState.completed);
        case AudioProcessingState.error:
          kantanPlaybackState.add(KantanPlaybackState.error);
      }
    });
  }

  PositionData get lastPositionData => PositionData(
        _player.position,
        _player.bufferedPosition,
        _player.duration ?? Duration.zero,
      );

  Stream<PositionData> get positionData {
    return Rx.combineLatest3(
      // AudioService.position has a weird behavior, maybe a bug, wherein
      // cycling through repeat modes resets the position to zero, so we're
      // using our own position data stream to prevent UI weirdness.
      _player.positionStream,
      playbackState.map((event) => event.bufferedPosition),
      mediaItem.map((event) => event?.duration),
      (position, bufferedPosition, duration) => PositionData(
        position,
        bufferedPosition,
        duration ?? Duration.zero,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
FutureOr<AudioHandlerService> audioHandler(Ref ref) async {
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.speech());
  final audioHandler = await AudioService.init(
    builder: () => AudioHandlerService(),
    config: AudioServiceConfig(
      androidNotificationChannelId: Config.channelId,
      androidNotificationChannelName: Config.channelName,
      // Setting androidStopForegroundOnPause would require the app the ask
      // users to disable battery optimization for the app. Given that this app
      // is meant to be accessible to young children and non-tech saavy adults,
      // that's probably not a safe thing to ask.
      androidStopForegroundOnPause: false,
      androidNotificationIcon: 'drawable/text_to_speech',
      rewindInterval: Config.rewindDuration,
      fastForwardInterval: Config.fastForwardDuration,
    ),
  );
  audioHandler.loadState(ref);
  audioHandler.saveState(ref);
  return audioHandler;
}

@riverpod
Stream<KantanPlaybackState> kantanPlaybackStateStream(Ref ref) {
  final audioHandler = ref.watch(audioHandlerProvider).requireValue;
  return audioHandler.kantanPlaybackState;
}

@riverpod
Stream<int?> queueIndexStream(Ref ref) {
  final audioHandler = ref.watch(audioHandlerProvider).requireValue;
  return audioHandler.playbackState.map((event) => event.queueIndex);
}

@riverpod
Stream<RepeatMode> repeatModeStream(Ref ref) {
  final audioHandler = ref.watch(audioHandlerProvider).requireValue;
  return audioHandler.repeatMode;
}

@riverpod
Stream<PositionData> positionDataStream(Ref ref) {
  final audioHandler = ref.watch(audioHandlerProvider).requireValue;
  return audioHandler.positionData;
}

@riverpod
Stream<double> speedStream(Ref ref) {
  final audioHandler = ref.watch(audioHandlerProvider).requireValue;
  return audioHandler.player.speedStream;
}
