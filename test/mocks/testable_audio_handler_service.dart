import 'dart:async';
import 'package:flutter/services.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';
import 'package:kantan/src/features/player/application/audio_handler_service.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const track1 = MediaItem(id: 'i1', title: 't1', duration: audioSourceDuration);
const track2 = MediaItem(id: 'i2', title: 't2', duration: audioSourceDuration);
const track3 = MediaItem(id: 'i3', title: 't3', duration: audioSourceDuration);
const track4 = MediaItem(id: 'i4', title: 't4', duration: audioSourceDuration);
const audioSourceDuration = Duration(minutes: 2);

final testPlaylist = [track1, track2, track3];

late TestableAudioHandlerService audioHandler;

Future<TestableAudioHandlerService> makeLoadedAudioHandler() async {
  final audioHandler = TestableAudioHandlerService();
  await audioHandler.addQueueItems(testPlaylist);
  await Future<dynamic>.delayed(const Duration(microseconds: 100));
  await audioHandler.load();
  return audioHandler;
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
