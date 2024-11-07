import 'dart:async';
import 'package:flutter/services.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:kantan/src/features/player/domain/kantan_playback_state.dart';
import 'package:kantan/src/features/player/domain/position_data.dart';
import 'package:kantan/src/features/player/domain/repeat_mode.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:rxdart/rxdart.dart';

const track1 = MediaItem(id: 'i1', title: 't1', duration: audioSourceDuration);
const track2 = MediaItem(id: 'i2', title: 't2', duration: audioSourceDuration);
const track3 = MediaItem(id: 'i3', title: 't3', duration: audioSourceDuration);
const track4 = MediaItem(id: 'i4', title: 't4', duration: audioSourceDuration);
const audioSourceDuration = Duration(minutes: 2);

final testPlaylist = [track1, track2, track3];

// var audioHandler = TestableAudioHandlerService();
late TestableAudioHandlerService audioHandler;

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Set up mocks for just_audio.
  final mockJustAudio = MockJustAudio();
  JustAudioPlatform.instance = mockJustAudio;
  const audioSessionChannel = MethodChannel('com.ryanheise.audio_session');

  Future<TestableAudioHandlerService> makeLoadedAudioHandler() async {
    final audioHandler = TestableAudioHandlerService();
    await audioHandler.addQueueItems(testPlaylist);
    await Future<dynamic>.delayed(const Duration(microseconds: 100));
    await audioHandler.load();
    return audioHandler;
  }

  void expectDuration(Duration a, Duration b, {int epsilon = 200}) {
    expect((a - b).inMilliseconds.abs(), lessThanOrEqualTo(epsilon));
  }

  void expectState({
    required TestableAudioHandlerService audioHandler,
    Duration? position,
    AudioProcessingState? processingState,
    bool? playing,
  }) {
    final state = audioHandler.playbackState.value;
    if (position != null) {
      expectDuration(state.updatePosition, position);
    }
    if (processingState != null) {
      expect(state.processingState, equals(processingState));
    }
    if (playing != null) {
      expect(state.playing, equals(playing));
    }
  }

  setUpAll(() {
    _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
        .defaultBinaryMessenger
        .setMockMethodCallHandler(audioSessionChannel,
            (MethodCall methodCall) async {
      return null;
    });
  });

  tearDownAll(() {
    _ambiguate(TestDefaultBinaryMessengerBinding.instance)!
        .defaultBinaryMessenger
        .setMockMethodCallHandler(audioSessionChannel, null);
  });

  group('Init:', () {
    test('Bare AudioPlayer initializes without incident.', () async {
      final player = AudioPlayer();
      expect(player.processingState, equals(ProcessingState.idle));
      expect(player.position, equals(Duration.zero));
      expect(player.bufferedPosition, equals(Duration.zero));
      expect(player.duration, equals(null));
      expect(player.icyMetadata, equals(null));
      expect(player.currentIndex, equals(null));
      expect(player.androidAudioSessionId, equals(null));
      expect(player.playing, equals(false));
      expect(player.volume, equals(1.0));
      expect(player.speed, equals(1.0));
      expect(player.sequence, equals(null));
      expect(player.hasNext, equals(false));
      expect(player.hasPrevious, equals(false));
      expect(player.loopMode, equals(LoopMode.off));
      expect(player.shuffleModeEnabled, equals(false));
      expect(player.automaticallyWaitsToMinimizeStalling, equals(true));
      await player.dispose();
    });

    test('Audio handler has the correct default vaules.', () {
      final audioHandler = TestableAudioHandlerService();
      final actual = audioHandler.playbackState.value;
      expect(actual, equals(PlaybackState(updateTime: actual.updateTime)));
      expect(actual.updateTime.microsecond,
          closeTo(DateTime.now().millisecond, 1000));
      expect(audioHandler.queueTitle.value, equals(''));
      expect(audioHandler.mediaItem.value, isNull);
      expect(audioHandler.androidPlaybackInfo,
          isA<BehaviorSubject<AndroidPlaybackInfo>>());
      expect(audioHandler.ratingStyle, isA<BehaviorSubject<RatingStyle>>());
      expect(audioHandler.customEvent, isA<PublishSubject<dynamic>>());
      expect(audioHandler.customState, isA<BehaviorSubject<dynamic>>());
    });

    test('Audio player has the correct default values.', () {
      final audioHandler = TestableAudioHandlerService();
      final player = audioHandler.player;
      expect(player.processingState, equals(ProcessingState.idle));
      expect(player.position, equals(Duration.zero));
      expect(player.bufferedPosition, equals(Duration.zero));
      expect(player.duration, equals(null));
      expect(player.icyMetadata, equals(null));
      expect(player.currentIndex, equals(null));
      expect(player.androidAudioSessionId, equals(null));
      expect(player.playing, equals(false));
      expect(player.volume, equals(1.0));
      expect(player.speed, equals(1.0));
      expect(player.sequence, equals([]));
      expect(player.hasNext, equals(false));
      expect(player.hasPrevious, equals(false));
      expect(player.loopMode, equals(LoopMode.off));
      expect(player.shuffleModeEnabled, equals(false));
      expect(player.automaticallyWaitsToMinimizeStalling, equals(true));
    });

    test('Load the initial empty playlist.', () async {
      final audioHandler = TestableAudioHandlerService();
      expect(audioHandler.queue.value.length, equals(0));
      expect(audioHandler.player.sequence?.length, equals(0));
      expectState(
        audioHandler: audioHandler,
        processingState: AudioProcessingState.idle,
      );
    });

    test('PostionData stream emits values.', () async {
      final audioHandler = await makeLoadedAudioHandler();
      const expectedPosition = PositionData(
        Duration.zero,
        Duration.zero,
        Duration(minutes: 2),
      );
      expect(audioHandler.positionData, emits(expectedPosition));
    });
  });

  group('Load state:', () {
    setUp(() async {
      audioHandler = await makeLoadedAudioHandler();
    });

    tearDown(() async {
      await audioHandler.dispose();
    });

    test('Load nothing, expect default values.', () async {
      final state = audioHandler.playbackState.value;
      const defaultPositionData = PositionData(
        Duration.zero,
        Duration.zero,
        audioSourceDuration,
      );
      expect(state.queueIndex, equals(0));
      expect(audioHandler.positionData, emits(defaultPositionData));
      expect(state.speed, equals(1.0));
      expect(state.processingState, equals(AudioProcessingState.ready));
    });

    test('Load queue index.', () async {
      await audioHandler.loadState(queueIndex: 1);
      final queueIndex = audioHandler.playbackState.value.queueIndex;
      expect(queueIndex, equals(1));
    });

    test('Load position.', () async {
      await audioHandler.loadState(position: const Duration(seconds: 5));
      const expectedPositionData = PositionData(
        Duration(seconds: 5),
        Duration(seconds: 5),
        audioSourceDuration,
      );
      expect(audioHandler.positionData, emits(expectedPositionData));
    });

    test('Load repeat mode.', () async {
      await audioHandler.loadState(repeatMode: RepeatMode.one);
      expect(audioHandler.repeatMode, emits(RepeatMode.one));
    });

    test('Load speed.', () async {
      await audioHandler.setSpeed(1.5);
      expect(audioHandler.player.speed, equals(1.5));
    });
  });

  group('Playlist:', () {
    setUp(() async {
      audioHandler = await makeLoadedAudioHandler();
    });

    tearDown(() async {
      await audioHandler.dispose();
    });

    test('Load a playlist.', () async {
      expect(audioHandler.queue.value.length, equals(3));
      expect(audioHandler.player.sequence?.length, equals(3));
      expect(audioHandler.mediaItem.value, equals(track1));
    });

    test('Add a track.', () async {
      await audioHandler.addQueueItem(track4);
      expect(audioHandler.queue.value.length, equals(4));
      expect(audioHandler.player.sequence?.length, equals(4));
    });

    test('Remove a track.', () async {
      audioHandler.removeQueueItemAt(0);
      expect(audioHandler.queue.value.length, equals(2));
      expect(audioHandler.player.sequence?.length, equals(2));
    });
  });

  group('Playback control:', () {
    setUp(() async {
      audioHandler = await makeLoadedAudioHandler();
    });

    tearDown(() async {
      await audioHandler.dispose();
    });

    test('Play.', () async {
      final isPlayingStream = audioHandler.playbackState.map((event) {
        return event.playing;
      });
      audioHandler.play();
      expect(isPlayingStream, emits(isTrue));
      expect(audioHandler.playCount, equals(1));
    });

    test('Pause.', () async {
      final isPlayingStream = audioHandler.playbackState.map((event) {
        return event.playing;
      });
      audioHandler.play();
      audioHandler.pause();
      expect(isPlayingStream, emits(isFalse));
      expect(audioHandler.pauseCount, equals(1));
    });

    test('Skip to track at index.', () async {
      await audioHandler.skipToQueueItem(2);
      expect(audioHandler.mediaItem.value, equals(track3));
    });

    test('Skip to next track.', () async {
      expect(audioHandler.mediaItem.value, equals(track1));
      await audioHandler.skipToNext();
      expect(audioHandler.skipToNextCount, equals(1));
      expect(audioHandler.mediaItem.value, equals(track2));
    });

    test('Skip to previous track.', () async {
      await audioHandler.skipToQueueItem(2);
      await audioHandler.skipToPrevious();
      expect(audioHandler.skipToPreviousCount, equals(1));
      expect(audioHandler.mediaItem.value, equals(track2));
    });

    test('hasPrevious is false at the beginning of playlist.', () async {
      expect(audioHandler.hasPrevious, isFalse);
    });

    test('hasPrevious is true in the middle of a playlist.', () async {
      await audioHandler.skipToQueueItem(1);
      expect(audioHandler.hasPrevious, isTrue);
    });

    test('hasNext is false at the end of a playlist.', () async {
      await audioHandler.skipToQueueItem(testPlaylist.length - 1);
      expect(audioHandler.hasNext, isFalse);
    });

    test('hasNext is true in the middle of a playlist.', () async {
      await audioHandler.skipToQueueItem(1);
      expect(audioHandler.hasNext, isTrue);
    });

    test('Seek to position.', () async {
      await audioHandler.seek(const Duration(seconds: 1));
      const expectedPositionData = PositionData(
        Duration(seconds: 1),
        Duration(seconds: 1),
        Duration(minutes: 2),
      );
      expect(audioHandler.positionData, emits(expectedPositionData));
    });

    // I can't seem to get --dart-define-from-file working inside of tests, fast
    // forward and rewind durations are set via that feature, so currently I'm
    // not sure how to test these methods.
    // TODO: Test fast forward.
    // TODO: Test rewind.

    test('Default repeat mode is non-repeating.', () async {
      final repeatMode = audioHandler.playbackState.value.repeatMode;
      final loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.none));
      expect(loopMode, equals(LoopMode.off));
      expect(audioHandler.repeatMode, emits(RepeatMode.none));
    });

    test('Set repeat mode to repeat one.', () async {
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
      final repeatMode = audioHandler.playbackState.value.repeatMode;
      final loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.one));
      expect(loopMode, equals(LoopMode.one));
      expect(audioHandler.repeatMode, emits(RepeatMode.one));
    });

    test('Set repeat mode to repeat all.', () async {
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
      final repeatMode = audioHandler.playbackState.value.repeatMode;
      final loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.all));
      expect(loopMode, equals(LoopMode.all));
      expect(audioHandler.repeatMode, emits(RepeatMode.all));
    });

    test('Cycle repeat modes.', () async {
      await audioHandler.nextRepeatMode();
      var repeatMode = audioHandler.playbackState.value.repeatMode;
      var loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.one));
      expect(loopMode, equals(LoopMode.one));
      expect(audioHandler.repeatMode, emits(RepeatMode.one));

      await audioHandler.nextRepeatMode();
      repeatMode = audioHandler.playbackState.value.repeatMode;
      loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.all));
      expect(loopMode, equals(LoopMode.all));
      expect(audioHandler.repeatMode, emits(RepeatMode.all));

      await audioHandler.nextRepeatMode();
      repeatMode = audioHandler.playbackState.value.repeatMode;
      loopMode = audioHandler.player.loopMode;
      expect(repeatMode, equals(AudioServiceRepeatMode.none));
      expect(loopMode, equals(LoopMode.off));
      expect(audioHandler.repeatMode, emits(RepeatMode.none));
    });

    test('Skip to next track in queue in repeat one moode.', () async {
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
      await audioHandler.skipToNext();
      final queueIndex = audioHandler.playbackState.value.queueIndex;
      expect(queueIndex, equals(1));
    });

    test('Skip to previous track in queue in repeat one moode.', () async {
      await audioHandler.skipToQueueItem(2);
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
      await audioHandler.skipToPrevious();
      final queueIndex = audioHandler.playbackState.value.queueIndex;
      expect(queueIndex, equals(1));
    });

    test('Set speed.', () async {
      await audioHandler.setSpeed(2.0);
      expect(audioHandler.player.speed, equals(2.0));
    });
  });

  group('KantanPlaybackState stream:', () {
    setUp(() async {
      audioHandler = await makeLoadedAudioHandler();
    });

    tearDown(() async {
      await audioHandler.dispose();
    });

    test('Init with loading state before queue items are added.', () {
      final unloadedAudioHandler = TestableAudioHandlerService();
      final unloadedStateStream = unloadedAudioHandler.kantanPlaybackState;
      expect(unloadedStateStream, emits(KantanPlaybackState.loading));
    });

    test('Emit paused state after loading queue.', () {
      final state = audioHandler.kantanPlaybackState.value;
      expect(state, equals(KantanPlaybackState.paused));
    });

    test('Emit playing state while audio source is playing.', () async {
      audioHandler.play();
      await Future.delayed(const Duration(milliseconds: 100));
      final state = audioHandler.kantanPlaybackState.value;
      expect(state, equals(KantanPlaybackState.playing));
    });

    test('Emit paused state while explicitly paused.', () async {
      audioHandler.play();
      await Future.delayed(const Duration(milliseconds: 100));
      audioHandler.pause();
      await Future.delayed(const Duration(milliseconds: 100));
      final state = audioHandler.kantanPlaybackState.value;
      expect(state, KantanPlaybackState.paused);
    });

    test('Emit completed state.', () async {
      audioHandler.playbackState.add(
        audioHandler.playbackState.value.copyWith(
          processingState: AudioProcessingState.completed,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        audioHandler.kantanPlaybackState,
        emits(KantanPlaybackState.completed),
      );
      final state = audioHandler.kantanPlaybackState.value;
      expect(state, KantanPlaybackState.completed);
    });

    test('Emit error state.', () async {
      audioHandler.playbackState.add(
        audioHandler.playbackState.value.copyWith(
          processingState: AudioProcessingState.error,
        ),
      );
      await Future.delayed(const Duration(milliseconds: 100));
      final state = audioHandler.kantanPlaybackState.value;
      expect(state, KantanPlaybackState.error);
    });
  });
}

class TestableAudioHandlerService extends AudioHandlerService {
  int playCount = 0;
  int pauseCount = 0;
  int skipToNextCount = 0;
  int skipToPreviousCount = 0;

  TestableAudioHandlerService() {
    listenToPosition();
  }

  void listenToPosition() {
    player.positionStream.listen((position) {
      playbackState.add(playbackState.value.copyWith(updatePosition: position));
    });
  }

  @override
  Future<void> play() async {
    playCount++;
    await super.play();
  }

  @override
  Future<void> pause() async {
    pauseCount++;
    await super.pause();
  }

  @override
  Future<void> skipToNext() async {
    skipToNextCount++;
    await super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    skipToPreviousCount++;
    await super.skipToPrevious();
  }
}

class MockAudioPlayer extends AudioPlayerPlatform {
  final eventController = StreamController<PlaybackEventMessage>();
  final AudioLoadConfigurationMessage? audioLoadConfiguration;
  AudioSourceMessage? _audioSource;
  ProcessingStateMessage _processingState = ProcessingStateMessage.idle;
  Duration _updatePosition = Duration.zero;
  DateTime _updateTime = DateTime.now();
  // ignore: prefer_final_fields
  Duration? _duration;
  int? _index;
  var _playing = false;
  var _speed = 1.0;
  Completer<dynamic>? _playCompleter;
  Timer? _playTimer;
  LoopModeMessage _loopMode = LoopModeMessage.off;

  MockAudioPlayer(InitRequest request)
      : audioLoadConfiguration = request.audioLoadConfiguration,
        super(request.id);

  @override
  Stream<PlayerDataMessage> get playerDataMessageStream =>
      StreamController<PlayerDataMessage>().stream;

  @override
  Stream<PlaybackEventMessage> get playbackEventMessageStream =>
      eventController.stream;

  @override
  Future<LoadResponse> load(LoadRequest request) async {
    final audioSource = request.audioSourceMessage;
    _processingState = ProcessingStateMessage.loading;
    _broadcastPlaybackEvent();
    if (audioSource is UriAudioSourceMessage) {
      if (audioSource.uri.contains('abort')) {
        throw PlatformException(code: 'abort', message: 'Failed to load URL');
      } else if (audioSource.uri.contains('404')) {
        throw PlatformException(code: '404', message: 'Not found');
      } else if (audioSource.uri.contains('error')) {
        throw PlatformException(code: 'error', message: 'Unknown error');
      }
      _duration = audioSourceDuration;
    } else if (audioSource is ClippingAudioSourceMessage) {
      _duration = (audioSource.end ?? audioSourceDuration) -
          (audioSource.start ?? Duration.zero);
    } else {
      // TODO: pull the sequence out of the audio source and return the duration
      // of the first item in the sequence.
      _duration = audioSourceDuration;
    }
    _audioSource = audioSource;
    _index = request.initialIndex ?? 0;
    // Simulate loading time.
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    _setPosition(request.initialPosition ?? Duration.zero);
    _processingState = ProcessingStateMessage.ready;
    _broadcastPlaybackEvent();
    if (_playing) {
      _startTimer();
    }
    return LoadResponse(duration: _duration);
  }

  @override
  Future<PlayResponse> play(PlayRequest request) async {
    if (_playing) return PlayResponse();
    _playing = true;
    if (_duration != null) {
      _startTimer();
    }
    _playCompleter = Completer<dynamic>();
    await _playCompleter!.future;
    return PlayResponse();
  }

  void _startTimer() {
    _playTimer = Timer(_remaining, () {
      _setPosition(_position);
      _processingState = ProcessingStateMessage.completed;
      _broadcastPlaybackEvent();
      _playCompleter?.complete();
    });
  }

  @override
  Future<PauseResponse> pause(PauseRequest request) async {
    if (!_playing) return PauseResponse();
    _playing = false;
    _playTimer?.cancel();
    _playCompleter?.complete();
    _setPosition(_position);
    _broadcastPlaybackEvent();
    return PauseResponse();
  }

  @override
  Future<SeekResponse> seek(SeekRequest request) async {
    _setPosition(request.position ?? Duration.zero);
    _index = request.index ?? 0;
    _broadcastPlaybackEvent();
    return SeekResponse();
  }

  Future<void> _autoAdvance() async {
    _setPosition(Duration.zero);
    if (_loopMode == LoopModeMessage.off) {
      _index = _index! + 1;
    }
    _broadcastPlaybackEvent();
  }

  @override
  Future<SetAndroidAudioAttributesResponse> setAndroidAudioAttributes(
      SetAndroidAudioAttributesRequest request) async {
    return SetAndroidAudioAttributesResponse();
  }

  @override
  Future<SetAutomaticallyWaitsToMinimizeStallingResponse>
      setAutomaticallyWaitsToMinimizeStalling(
          SetAutomaticallyWaitsToMinimizeStallingRequest request) async {
    return SetAutomaticallyWaitsToMinimizeStallingResponse();
  }

  @override
  Future<SetLoopModeResponse> setLoopMode(SetLoopModeRequest request) async {
    _loopMode = request.loopMode;
    return SetLoopModeResponse();
  }

  @override
  Future<SetShuffleModeResponse> setShuffleMode(
      SetShuffleModeRequest request) async {
    return SetShuffleModeResponse();
  }

  @override
  Future<SetShuffleOrderResponse> setShuffleOrder(
      SetShuffleOrderRequest request) async {
    return SetShuffleOrderResponse();
  }

  @override
  Future<SetSpeedResponse> setSpeed(SetSpeedRequest request) async {
    _speed = request.speed;
    _setPosition(_position);
    return SetSpeedResponse();
  }

  @override
  Future<SetPitchResponse> setPitch(SetPitchRequest request) async {
    return SetPitchResponse();
  }

  @override
  Future<SetSkipSilenceResponse> setSkipSilence(
      SetSkipSilenceRequest request) async {
    return SetSkipSilenceResponse();
  }

  @override
  Future<SetVolumeResponse> setVolume(SetVolumeRequest request) async {
    return SetVolumeResponse();
  }

  @override
  Future<DisposeResponse> dispose(DisposeRequest request) async {
    _processingState = ProcessingStateMessage.idle;
    _broadcastPlaybackEvent();
    return DisposeResponse();
  }

  @override
  Future<ConcatenatingInsertAllResponse> concatenatingInsertAll(
      ConcatenatingInsertAllRequest request) async {
    // TODO
    return ConcatenatingInsertAllResponse();
  }

  @override
  Future<ConcatenatingMoveResponse> concatenatingMove(
      ConcatenatingMoveRequest request) async {
    // TODO
    return ConcatenatingMoveResponse();
  }

  @override
  Future<ConcatenatingRemoveRangeResponse> concatenatingRemoveRange(
      ConcatenatingRemoveRangeRequest request) async {
    // TODO
    return ConcatenatingRemoveRangeResponse();
  }

  void _broadcastPlaybackEvent() {
    String? url;
    if (_audioSource is UriAudioSourceMessage) {
      // Not sure why this cast is necessary...
      url = (_audioSource as UriAudioSourceMessage).uri.toString();
    }
    eventController.add(PlaybackEventMessage(
      processingState: _processingState,
      updatePosition: _updatePosition,
      updateTime: _updateTime,
      bufferedPosition: _position,
      icyMetadata: IcyMetadataMessage(
        headers: IcyHeadersMessage(
          url: url,
          genre: 'Genre',
          metadataInterval: 3,
          bitrate: 100,
          isPublic: true,
          name: 'name',
        ),
        info: IcyInfoMessage(
          title: 'title',
          url: url,
        ),
      ),
      duration: _duration,
      currentIndex: _index,
      androidAudioSessionId: null,
    ));
  }

  Duration get _position {
    if (_playing && _processingState == ProcessingStateMessage.ready) {
      final result =
          _updatePosition + (DateTime.now().difference(_updateTime)) * _speed;
      return result <= _duration! ? result : _duration!;
    } else {
      return _updatePosition;
    }
  }

  Duration get _remaining => (_duration! - _position) * (1 / _speed);

  void _setPosition(Duration position) {
    _updatePosition = position;
    _updateTime = DateTime.now();
  }

  @override
  Future<SetCanUseNetworkResourcesForLiveStreamingWhilePausedResponse>
      setCanUseNetworkResourcesForLiveStreamingWhilePaused(
          SetCanUseNetworkResourcesForLiveStreamingWhilePausedRequest
              request) async {
    return SetCanUseNetworkResourcesForLiveStreamingWhilePausedResponse();
  }

  @override
  Future<SetPreferredPeakBitRateResponse> setPreferredPeakBitRate(
      SetPreferredPeakBitRateRequest request) async {
    return SetPreferredPeakBitRateResponse();
  }

  @override
  Future<AudioEffectSetEnabledResponse> audioEffectSetEnabled(
      AudioEffectSetEnabledRequest request) async {
    return AudioEffectSetEnabledResponse();
  }

  @override
  Future<AndroidLoudnessEnhancerSetTargetGainResponse>
      androidLoudnessEnhancerSetTargetGain(
          AndroidLoudnessEnhancerSetTargetGainRequest request) async {
    return AndroidLoudnessEnhancerSetTargetGainResponse();
  }

  @override
  Future<AndroidEqualizerGetParametersResponse> androidEqualizerGetParameters(
      AndroidEqualizerGetParametersRequest request) async {
    return AndroidEqualizerGetParametersResponse(
      parameters: AndroidEqualizerParametersMessage(
        minDecibels: 0.0,
        maxDecibels: 10.0,
        bands: [
          for (var i = 0; i < 5; i++)
            AndroidEqualizerBandMessage(
              index: i,
              lowerFrequency: i * 1000,
              upperFrequency: (i + 1) * 1000,
              centerFrequency: (i + 0.5) * 1000,
              gain: i * 0.1,
            ),
        ],
      ),
    );
  }

  @override
  Future<AndroidEqualizerBandSetGainResponse> androidEqualizerBandSetGain(
      AndroidEqualizerBandSetGainRequest request) async {
    return AndroidEqualizerBandSetGainResponse();
  }
}

final byteRangeData = List.generate(200, (i) => i);

class TestStreamAudioSource extends StreamAudioSource {
  TestStreamAudioSource({dynamic tag}) : super(tag: tag);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      contentType: 'audio/mock',
      stream: Stream.value(byteRangeData.sublist(start ?? 0, end)),
      contentLength: (end ?? byteRangeData.length) - (start ?? 0),
      offset: start ?? 0,
      sourceLength: byteRangeData.length,
    );
  }
}

class MockJustAudio extends Mock
    with MockPlatformInterfaceMixin
    implements JustAudioPlatform {
  MockAudioPlayer? mostRecentPlayer;
  final _players = <String, MockAudioPlayer>{};

  @override
  Future<AudioPlayerPlatform> init(InitRequest request) async {
    if (_players.containsKey(request.id)) {
      throw PlatformException(
          code: "error",
          message: "Platform player ${request.id} already exists");
    }
    final player = MockAudioPlayer(request);
    _players[request.id] = player;
    mostRecentPlayer = player;
    return player;
  }

  @override
  Future<DisposePlayerResponse> disposePlayer(
      DisposePlayerRequest request) async {
    _players[request.id]!.dispose(DisposeRequest());
    _players.remove(request.id);
    return DisposePlayerResponse();
  }

  @override
  Future<DisposeAllPlayersResponse> disposeAllPlayers(
      DisposeAllPlayersRequest request) async {
    for (var player in _players.values) {
      player.dispose(DisposeRequest());
    }
    _players.clear();
    return DisposeAllPlayersResponse();
  }
}

T? _ambiguate<T>(T? value) => value;
